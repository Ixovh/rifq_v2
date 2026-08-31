import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/presentation/widgets/pet_label_helpers.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AccountPetCard extends StatelessWidget {
  const AccountPetCard({
    super.key,
    required this.pet,
    this.onTap,
    this.onEditTap,
    this.fullWidth = false,
  });

  final AccountPetEntity pet;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: fullWidth ? double.infinity : 256.w,
      margin: EdgeInsetsDirectional.only(
        end: fullWidth ? 0 : 12.w,
        bottom: fullWidth ? 12.h : 0,
      ),
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFF),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFECECEC)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29585C5F),
            blurRadius: 40,
            offset: Offset(0, 16.h),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.petProfile_title,
                style: context.body3.copyWith(
                  color: context.neutral500,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              if (pet.listedForAdoption) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: context.primary100,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: context.primary300),
                  ),
                  child: Text(
                    l10n.account_listedForAdoption,
                    style: context.body3.copyWith(
                      color: context.primary300,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onEditTap,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 16.sp,
                    color: context.primary300,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Material(
            color: context.primary100,
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 43.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.primary300),
                        color: context.neutral100,
                        image: pet.photoUrl != null && pet.photoUrl!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(pet.photoUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: pet.photoUrl == null || pet.photoUrl!.isEmpty
                          ? Icon(
                              Icons.pets,
                              color: context.primary300,
                              size: 20.sp,
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        pet.name,
                        style: context.body2.copyWith(
                          fontSize: 18.sp,
                          letterSpacing: 0.9,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: context.neutral1000,
                      size: 20.sp,
                      textDirection: Directionality.of(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MetaColumn(
                label: l10n.common_gender,
                value: petGenderLabel(context, pet.gender),
              ),
              _MetaColumn(
                label: l10n.common_age,
                value: petAgeLabel(context, pet),
                alignCenter: true,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.common_breed,
            style: context.body3.copyWith(
              color: context.neutral500,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            pet.breed.isEmpty ? '-' : pet.breed,
            style: context.body3.copyWith(
              color: context.neutral1000,
              fontSize: 10.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _MetaColumn extends StatelessWidget {
  const _MetaColumn({
    required this.label,
    required this.value,
    this.alignCenter = false,
  });

  final String label;
  final String value;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignCenter
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.body3.copyWith(
            color: context.neutral500,
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: context.body3.copyWith(
            color: context.neutral1000,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
