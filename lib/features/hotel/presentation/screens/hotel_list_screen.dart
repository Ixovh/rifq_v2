import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/home_boarding/presentation/cubit/home_boarding_list_cubit.dart';
import 'package:rifq_v2/features/home_boarding/presentation/widgets/sitter_card_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/cubit/hotel_list_cubit.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/boarding_list_toolbar_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_card_widget.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/custom_app_bar.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

@RoutePage()
class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<HotelListCubit>()..loadHotels()),
        BlocProvider(
          create: (_) => GetIt.I<HomeBoardingListCubit>()..loadSitters(),
        ),
      ],
      child: const _HotelListView(),
    );
  }
}

class _HotelListView extends StatefulWidget {
  const _HotelListView();

  @override
  State<_HotelListView> createState() => _HotelListViewState();
}

class _HotelListViewState extends State<_HotelListView> {
  BoardingTab _activeTab = BoardingTab.hotels;

  void _onTabChanged(BoardingTab tab) => setState(() => _activeTab = tab);

  void _openHotelDetail(String hotelId) {
    context.pushRoute(HotelDetailRoute(hotelId: hotelId));
  }

  void _openSitterDetail(String sitterId) {
    // Wired up once the Sitter Detail screen lands (next commit).
  }

  void _openSearch() {
    // Wired up once the Search screen lands.
  }

  void _openFilter() {
    // Wired up once the Sort/Filter modal lands.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: const CustomAppBar(title: 'Hotel'),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              BoardingListToolbar(
                activeTab: _activeTab,
                onTabChanged: _onTabChanged,
                onSearchTap: _openSearch,
                onFilterTap: _openFilter,
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: IndexedStack(
                  index: _activeTab == BoardingTab.hotels ? 0 : 1,
                  children: [
                    _HotelsTabBody(onOpenDetail: _openHotelDetail),
                    _HomeBoardingTabBody(onOpenDetail: _openSitterDetail),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HotelsTabBody extends StatelessWidget {
  const _HotelsTabBody({required this.onOpenDetail});

  final ValueChanged<String> onOpenDetail;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelListCubit, HotelListState>(
      builder: (context, state) {
        if (state is HotelListLoading || state is HotelListInitial) {
          return const LottieLoding();
        }

        if (state is HotelListError) {
          return _MessageView(
            message: state.msg,
            onRetry: () => context.read<HotelListCubit>().loadHotels(),
          );
        }

        if (state is HotelListEmpty) {
          return const _MessageView(
            message: 'No hotels available right now — check back soon.',
          );
        }

        if (state is HotelListLoaded) {
          return RefreshIndicator(
            onRefresh: () => context.read<HotelListCubit>().loadHotels(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 16.h),
              itemCount: state.hotels.length,
              separatorBuilder: (_, _) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final hotel = state.hotels[index];
                return HotelCard(
                  hotel: hotel,
                  onTap: () => onOpenDetail(hotel.id),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _HomeBoardingTabBody extends StatelessWidget {
  const _HomeBoardingTabBody({required this.onOpenDetail});

  final ValueChanged<String> onOpenDetail;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBoardingListCubit, HomeBoardingListState>(
      builder: (context, state) {
        if (state is HomeBoardingListLoading ||
            state is HomeBoardingListInitial) {
          return const LottieLoding();
        }

        if (state is HomeBoardingListError) {
          return _MessageView(
            message: state.msg,
            onRetry: () =>
                context.read<HomeBoardingListCubit>().loadSitters(),
          );
        }

        if (state is HomeBoardingListEmpty) {
          return const _MessageView(
            message: 'No sitters available right now — check back soon.',
          );
        }

        if (state is HomeBoardingListLoaded) {
          return RefreshIndicator(
            onRefresh: () =>
                context.read<HomeBoardingListCubit>().loadSitters(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 16.h),
              itemCount: state.sitters.length,
              separatorBuilder: (_, _) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final sitter = state.sitters[index];
                return SitterCard(
                  sitter: sitter,
                  onTap: () => onOpenDetail(sitter.id),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
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
          Icon(Icons.hotel_outlined, size: 64.sp, color: context.neutral400),
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
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
