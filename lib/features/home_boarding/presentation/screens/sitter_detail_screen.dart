import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/home_boarding/presentation/cubit/boarding_request_cubit.dart';
import 'package:rifq_v2/features/home_boarding/presentation/cubit/sitter_detail_cubit.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/book_now_button_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SitterDetailScreen extends StatelessWidget {
  const SitterDetailScreen({super.key, required this.sitterId});

  final String sitterId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              GetIt.I<SitterDetailCubit>()..loadSitterDetail(sitterId),
        ),
        BlocProvider(
          create: (_) =>
              GetIt.I<BoardingRequestCubit>()..checkExistingRequest(sitterId),
        ),
      ],
      child: _SitterDetailView(sitterId: sitterId),
    );
  }
}

class _SitterDetailView extends StatelessWidget {
  const _SitterDetailView({required this.sitterId});

  final String sitterId;

  Future<void> _contactSitter(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BoardingRequestCubit, BoardingRequestState>(
      listener: (context, state) {
        if (state is BoardingRequestSent) {
          context.router.push(const RequestSentRoute());
        } else if (state is BoardingRequestError) {
          context.showErrorToast(state.msg);
        }
      },
      child: Scaffold(
        backgroundColor: context.background,
        body: SafeArea(
          child: BlocBuilder<SitterDetailCubit, SitterDetailState>(
            builder: (context, state) {
              if (state is SitterDetailLoading ||
                  state is SitterDetailInitial) {
                return const LottieLoding();
              }

              if (state is SitterDetailError) {
                return _ErrorView(
                  message: state.msg,
                  onRetry: () => context
                      .read<SitterDetailCubit>()
                      .loadSitterDetail(sitterId),
                );
              }

              final detail = (state as SitterDetailLoaded).detail;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.router.maybePop(),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: context.neutral1000,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 24.h),
                      children: [
                        Center(child: _SitterAvatar(imageUrl: detail.imageUrl)),
                        SizedBox(height: 12.h),
                        Center(
                          child: Text(
                            detail.name,
                            style: context.h4.copyWith(
                              color: context.neutral1000,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Center(
                          child: Text(
                            detail.specialty,
                            style: context.body2.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star_rounded,
                                  size: 16.sp,
                                  color: i < detail.rating.round()
                                      ? context.warning
                                      : context.neutral300,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '(${detail.reviewCount} reviews)',
                                style: context.body3.copyWith(
                                  color: context.neutral600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _InfoChip(
                              icon: Icons.location_on_outlined,
                              label: detail.areaText,
                            ),
                            _InfoChip(
                              icon: Icons.payments_outlined,
                              label:
                                  'SAR ${detail.pricePerNight.toStringAsFixed(0)}/night',
                            ),
                            _InfoChip(
                              icon: Icons.work_history_outlined,
                              label: '${detail.yearsExperience} yrs exp.',
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: detail.phoneNumber == null
                                ? null
                                : () => _contactSitter(detail.phoneNumber!),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              side: BorderSide(color: context.primary300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            icon: Icon(
                              Icons.call_outlined,
                              color: context.primary300,
                            ),
                            label: Text(
                              'Contact',
                              style: context.body2.copyWith(
                                color: context.primary300,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        if ((detail.bio ?? '').isNotEmpty) ...[
                          SizedBox(height: 20.h),
                          Text(
                            'About',
                            style: context.body1.copyWith(
                              color: context.neutral1000,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            detail.bio!,
                            style: context.body3.copyWith(
                              color: context.neutral700,
                            ),
                          ),
                        ],
                        if (detail.skills.isNotEmpty) ...[
                          SizedBox(height: 20.h),
                          Text(
                            'Skills',
                            style: context.body1.copyWith(
                              color: context.neutral1000,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: detail.skills
                                .map((skill) => _SkillTag(label: skill))
                                .toList(),
                          ),
                        ],
                        SizedBox(height: 24.h),
                        BlocBuilder<BoardingRequestCubit, BoardingRequestState>(
                          builder: (context, requestState) {
                            final alreadyPending =
                                requestState is BoardingRequestAlreadyPending;
                            final sending =
                                requestState is BoardingRequestSending;
                            return BookNowButton(
                              label: alreadyPending
                                  ? 'Request Pending'
                                  : 'Send Request',
                              isLoading: sending,
                              onPressed: alreadyPending
                                  ? null
                                  : () => context
                                        .read<BoardingRequestCubit>()
                                        .sendRequest(sitterId),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SitterAvatar extends StatelessWidget {
  const _SitterAvatar({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 110.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.neutral100,
        border: Border.all(color: context.primary300, width: 2),
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: imageUrl == null
          ? Icon(Icons.person, size: 48.sp, color: context.primary300)
          : null,
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.sp, color: context.primary300),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: context.body3.copyWith(
            color: context.neutral1000,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SkillTag extends StatelessWidget {
  const _SkillTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.primary100.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.primary100),
      ),
      child: Text(
        label,
        style: context.body3.copyWith(
          color: context.primary400,
          fontWeight: FontWeight.w600,
        ),
      ),
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
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: context.neutral1000,
                ),
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
