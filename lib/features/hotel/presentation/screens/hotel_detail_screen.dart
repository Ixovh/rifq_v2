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
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_back_icon.dart';

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
    final l10n = AppLocalizations.of(context)!;

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
          final locationText = detail.distanceKm == null
              ? detail.locationText
              : l10n.hotel_locationDistance(
                  detail.locationText,
                  detail.distanceKm!.toStringAsFixed(1),
                );

          return Column(
            children: [
              HotelImageCarousel(
                images: detail.images,
                title: detail.name,
                onBack: () => context.router.maybePop(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(28.w, 14.h, 28.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.name,
                      style: context.h4.copyWith(
                        color: context.neutral1000,
                        fontWeight: FontWeight.w500,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18.sp,
                          color: context.neutral600,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            locationText,
                            style: context.body2.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: TabBar(
                  controller: _tabController,
                  labelColor: context.primary300,
                  unselectedLabelColor: context.neutral300,
                  indicatorColor: context.primary300,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: context.neutral200,
                  labelStyle: context.body2,
                  unselectedLabelStyle: context.body2,
                  tabs: [
                    Tab(text: l10n.hotel_tabRooms),
                    Tab(text: l10n.hotel_tabInfo),
                  ],
                ),
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
                  padding: EdgeInsetsDirectional.fromSTEB(18.w, 8.h, 18.w, 12.h),
                  child: Center(
                    child: SizedBox(
                      width: 280.w,
                      child: BookNowButton(
                        onPressed: detail.rooms.isEmpty
                            ? null
                            : () => context.router.push(
                                BookingDetailsRoute(hotel: detail),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
    final l10n = AppLocalizations.of(context)!;

    if (detail.rooms.isEmpty && detail.services.isEmpty) {
      return Center(
        child: Text(
          l10n.hotel_noRooms,
          style: context.body2.copyWith(color: context.neutral600),
        ),
      );
    }

    return ListView(
      padding: EdgeInsetsDirectional.fromSTEB(30.w, 16.h, 30.w, 24.h),
      children: [
        for (var i = 0; i < detail.rooms.length; i++)
          HotelRoomCard(
            room: detail.rooms[i],
            showDivider:
                i != detail.rooms.length - 1 || detail.services.isNotEmpty,
          ),
        if (detail.services.isNotEmpty) ...[
          Text(
            l10n.hotel_otherServices,
            style: context.body2.copyWith(
              color: context.neutral900,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
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
    final l10n = AppLocalizations.of(context)!;
    final rules = detail.rules;

    return ListView(
      padding: EdgeInsetsDirectional.fromSTEB(25.w, 16.h, 25.w, 24.h),
      children: [
        Text(
          l10n.hotel_aboutTitle,
          style: context.body2.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          (detail.description ?? '').isEmpty
              ? l10n.hotel_noDescription
              : detail.description!,
          style: context.body3.copyWith(color: context.neutral700),
        ),
        if (detail.facilities.isNotEmpty) ...[
          SizedBox(height: 16.h),
          Text(
            l10n.hotel_facilities,
            style: context.body2.copyWith(
              color: context.neutral1000,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: detail.facilities
                .map(
                  (f) => HotelFacilityChip(name: f.name, category: f.category),
                )
                .toList(),
          ),
        ],
        if (rules.isNotEmpty) ...[
          SizedBox(height: 16.h),
          Text(
            l10n.hotel_rulesTitle,
            style: context.body2.copyWith(
              color: context.neutral1000,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          for (var i = 0; i < rules.length; i += 2)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
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
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: detail.hasLocation ? _openLocation : null,
            style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(36.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              side: BorderSide(color: context.primary300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.hotel_location,
                  style: context.body3.copyWith(
                    color: context.neutral1000,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.near_me_outlined,
                  size: 14.sp,
                  color: context.primary300,
                ),
              ],
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
                icon: AppBackIcon(color: context.neutral1000),
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
                  TextButton(
                    onPressed: onRetry,
                    child: Text(AppLocalizations.of(context)!.common_retry),
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
