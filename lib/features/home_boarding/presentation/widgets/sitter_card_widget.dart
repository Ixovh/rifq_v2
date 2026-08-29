import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class SitterCard extends StatelessWidget {
  const SitterCard({super.key, required this.sitter, required this.onTap});

  final HomeBoardingListItemEntity sitter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);

    return Material(
      color: Colors.white,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 84.w,
                  height: 84.w,
                  child: sitter.imageUrl == null
                      ? _AvatarPlaceholder(iconSize: 32.sp)
                      : Image.network(
                          sitter.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              _AvatarPlaceholder(iconSize: 32.sp),
                        ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sitter.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.body1.copyWith(
                        color: context.neutral1000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      sitter.specialty,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.body3.copyWith(color: context.neutral600),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            Icons.star_rounded,
                            size: 14.sp,
                            color: i < sitter.rating.round()
                                ? context.warning
                                : context.neutral300,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '(${sitter.reviewCount} reviews)',
                          style: context.body3.copyWith(
                            color: context.neutral600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    _IconLine(
                      icon: Icons.location_on_outlined,
                      text: sitter.areaText,
                    ),
                    SizedBox(height: 2.h),
                    _IconLine(
                      icon: Icons.payments_outlined,
                      text:
                          'SAR ${sitter.pricePerNight.toStringAsFixed(0)}/night'
                          ' · ${sitter.yearsExperience} yrs exp.',
                    ),
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

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder({this.iconSize});

  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.neutral100,
      child: Center(
        child: Icon(Icons.person, size: iconSize, color: context.neutral400),
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: context.neutral600),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.body3.copyWith(color: context.neutral700),
          ),
        ),
      ],
    );
  }
}
