import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/presentation/cubit/hotel_detail_cubit.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/book_now_button_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_facility_chip_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_image_carousel_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_room_card_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_rule_item_widget.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_service_row_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class HotelDetailScreen extends StatelessWidget {
  const HotelDetailScreen({super.key, required this.hotelId});

  final String hotelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HotelDetailCubit>()..loadHotelDetail(hotelId),
      child: _HotelDetailView(hotelId: hotelId),
    );
  }
}

class _HotelDetailView extends StatefulWidget {
  const _HotelDetailView({required this.hotelId});

  final String hotelId;

  @override
  State<_HotelDetailView> createState() => _HotelDetailViewState();
}

class _HotelDetailViewState extends State<_HotelDetailView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: BlocBuilder<HotelDetailCubit, HotelDetailState>(
        builder: (context, state) {
          if (state is HotelDetailLoading || state is HotelDetailInitial) {
            return const LottieLoding();
          }

          if (state is HotelDetailError) {
            return SafeArea(
              child: _ErrorView(
                message: state.msg,
                onRetry: () => context.read<HotelDetailCubit>().loadHotelDetail(
                  widget.hotelId,
                ),
              ),
            );
          }

          final detail = (state as HotelDetailLoaded).detail;

          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                HotelImageCarousel(
                  images: detail.images,
                  onBack: () => context.router.maybePop(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.name,
                        style: context.h4.copyWith(
                          color: context.neutral1000,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16.sp,
                            color: context.neutral600,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            detail.locationText,
                            style: context.body3.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                TabBar(
                  controller: _tabController,
                  labelColor: context.primary300,
                  unselectedLabelColor: context.neutral600,
                  indicatorColor: context.primary300,
                  indicatorWeight: 3,
                  labelStyle: context.body2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: context.body2,
                  tabs: const [Tab(text: 'Rooms'), Tab(text: 'Hotel Info')],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _RoomsTab(detail: detail),
                      _HotelInfoTab(detail: detail),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.all(18.w),
                    child: BookNowButton(
                      onPressed: detail.rooms.isEmpty
                          ? null
                          : () => context.router.push(
                              BookingDetailsRoute(hotel: detail),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RoomsTab extends StatelessWidget {
  const _RoomsTab({required this.detail});

  final HotelDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    if (detail.rooms.isEmpty && detail.services.isEmpty) {
      return Center(
        child: Text(
          'No rooms listed for this hotel yet.',
          style: context.body2.copyWith(color: context.neutral600),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
      children: [
        for (final room in detail.rooms) ...[
          HotelRoomCard(room: room),
          SizedBox(height: 12.h),
        ],
        if (detail.services.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            'Other Services',
            style: context.body1.copyWith(
              color: context.neutral1000,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          for (final service in detail.services)
            HotelServiceRow(service: service),
        ],
      ],
    );
  }
}

class _HotelInfoTab extends StatelessWidget {
  const _HotelInfoTab({required this.detail});

  final HotelDetailEntity detail;

  Future<void> _openLocation() async {
    if (!detail.hasLocation) return;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${detail.latitude},${detail.longitude}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rules = detail.rules;

    return ListView(
      padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
      children: [
        Text(
          'About the Hotel',
          style: context.body1.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          (detail.description ?? '').isEmpty
              ? 'No description available yet.'
              : detail.description!,
          style: context.body3.copyWith(color: context.neutral700),
        ),
        if (detail.facilities.isNotEmpty) ...[
          SizedBox(height: 20.h),
          Text(
            'Facilities',
            style: context.body1.copyWith(
              color: context.neutral1000,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: detail.facilities
                .map(
                  (f) => HotelFacilityChip(name: f.name, category: f.category),
                )
                .toList(),
          ),
        ],
        if (rules.isNotEmpty) ...[
          SizedBox(height: 20.h),
          Text(
            'Rules & Requirements',
            style: context.body1.copyWith(
              color: context.neutral1000,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          for (var i = 0; i < rules.length; i += 2)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: HotelRuleItem(ruleText: rules[i].ruleText)),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: i + 1 < rules.length
                        ? HotelRuleItem(ruleText: rules[i + 1].ruleText)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
        ],
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: detail.hasLocation ? _openLocation : null,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: BorderSide(color: context.primary300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            icon: Icon(Icons.location_on_outlined, color: context.primary300),
            label: Text(
              'Location',
              style: context.body2.copyWith(
                color: context.primary300,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () => context.router.maybePop(),
                icon: Icon(Icons.arrow_back_ios_new, color: context.neutral1000),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.body2.copyWith(color: context.neutral700),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(onPressed: onRetry, child: const Text('Retry')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
