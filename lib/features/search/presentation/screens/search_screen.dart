import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/features/home_boarding/presentation/widgets/sitter_card_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_card_widget.dart';
import 'package:rifq_v2/features/search/presentation/cubit/search_cubit.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.initialTab});

  final BoardingTab initialTab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SearchCubit>()..setTab(initialTab),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openHotelDetail(String hotelId) =>
      context.pushRoute(HotelDetailRoute(hotelId: hotelId));

  void _openSitterDetail(String sitterId) =>
      context.pushRoute(SitterDetailRoute(sitterId: sitterId));

  void _runRecent(String query) {
    _controller.text = query;
    _controller.selection = TextSelection.collapsed(offset: query.length);
    context.read<SearchCubit>().runRecentSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 8.h, 18.w, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.router.maybePop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: context.neutral1000,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onChanged: (q) =>
                          context.read<SearchCubit>().onQueryChanged(q),
                      onSubmitted: (q) =>
                          context.read<SearchCubit>().runRecentSearch(q),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.common_searchHint,
                        hintStyle: context.body2.copyWith(
                          color: context.neutral500,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.neutral500,
                          size: 20.sp,
                        ),
                        filled: true,
                        fillColor: context.neutral100,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: context.neutral200),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) return const LottieLoding();

                  if (state is SearchIdle) {
                    return _RecentSearches(
                      queries: state.recentSearches,
                      onTapQuery: _runRecent,
                      onRemoveQuery: (q) =>
                          context.read<SearchCubit>().removeRecentSearch(q),
                      onClearAll: () =>
                          context.read<SearchCubit>().clearRecentSearches(),
                    );
                  }

                  if (state is SearchEmpty) {
                    return _MessageView(message: AppLocalizations.of(context)!.search_noResults);
                  }

                  if (state is SearchError) {
                    return _MessageView(
                      message: AppLocalizations.of(context)!.search_error,
                      onRetry: () =>
                          context.read<SearchCubit>().retryLastSearch(),
                    );
                  }

                  if (state is SearchHotelResults) {
                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 16.h),
                      itemCount: state.hotels.length,
                      separatorBuilder: (_, _) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final hotel = state.hotels[index];
                        return HotelCard(
                          hotel: hotel,
                          onTap: () => _openHotelDetail(hotel.id),
                        );
                      },
                    );
                  }

                  if (state is SearchSitterResults) {
                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 16.h),
                      itemCount: state.sitters.length,
                      separatorBuilder: (_, _) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final sitter = state.sitters[index];
                        return SitterCard(
                          sitter: sitter,
                          onTap: () => _openSitterDetail(sitter.id),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  const _RecentSearches({
    required this.queries,
    required this.onTapQuery,
    required this.onRemoveQuery,
    required this.onClearAll,
  });

  final List<String> queries;
  final ValueChanged<String> onTapQuery;
  final ValueChanged<String> onRemoveQuery;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    if (queries.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.search_startTyping,
          style: context.body2.copyWith(color: context.neutral600),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.search_recentSearches,
              style: context.body1.copyWith(
                color: context.neutral1000,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: onClearAll,
              child: Text(
                AppLocalizations.of(context)!.search_clearAll,
                style: context.body3.copyWith(color: context.neutral600),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        for (final query in queries)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onTapQuery(query),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      size: 18.sp,
                      color: context.neutral500,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        query,
                        style: context.body2.copyWith(
                          color: context.neutral1000,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onRemoveQuery(query),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: context.neutral400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 64.sp, color: context.neutral400),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.body2.copyWith(color: context.neutral700),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 12.h),
            TextButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context)!.common_retry),
          ),
          ],
        ],
      ),
    );
  }
}
