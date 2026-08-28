import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/hotel/presentation/cubit/hotel_list_cubit.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_card_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_list_toolbar_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/custom_app_bar.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

@RoutePage()
class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HotelListCubit>()..loadHotels(),
      child: const _HotelListView(),
    );
  }
}

class _HotelListView extends StatelessWidget {
  const _HotelListView();

  void _openDetail(BuildContext context, String hotelId) {
    context.pushRoute(HotelDetailRoute(hotelId: hotelId));
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
              const HotelListToolbar(),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<HotelListCubit, HotelListState>(
                  builder: (context, state) {
                    if (state is HotelListLoading ||
                        state is HotelListInitial) {
                      return const LottieLoding();
                    }

                    if (state is HotelListError) {
                      return _MessageView(
                        message: state.msg,
                        onRetry: () =>
                            context.read<HotelListCubit>().loadHotels(),
                      );
                    }

                    if (state is HotelListLoaded) {
                      if (state.hotels.isEmpty) {
                        return const _MessageView(
                          message: 'No pet hotels found yet.',
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<HotelListCubit>().loadHotels(),
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 16.h),
                          itemCount: state.hotels.length,
                          separatorBuilder: (_, _) => SizedBox(height: 14.h),
                          itemBuilder: (context, index) {
                            final hotel = state.hotels[index];
                            return HotelCard(
                              hotel: hotel,
                              onTap: () => _openDetail(context, hotel.id),
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
