import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/domain/entities/my_adoption_pet_entity.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/utils/app_date_utils.dart';

class MyAdoptionPetCard extends StatelessWidget {
  final MyAdoptionPetEntity pet;
  final VoidCallback? onDelete;

  const MyAdoptionPetCard({
    super.key,
    required this.pet,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // IMAGE
          // ============================================================

          // _PetImage(
          //   imageUrl: pet.imageUrl,
          //   status: pet.status,
          // ),
          _PetImage(
            imageUrl: pet.imageUrl,
            status: pet.status,
            adoptionPostId: pet.adoptionPostId,
            onDelete: onDelete ?? () {},
          ),

          // ============================================================
          // INFO
          // ============================================================
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Gender
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        pet.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.body1.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: context.neutral700,
                        ),
                      ),
                    ),

                    // Gender
                    _GenderIcon(),
                  ],
                ),

                SizedBox(height: 7.h),

                // Location
                _InfoRow(icon: Icons.location_on_outlined, text: pet.location),

                SizedBox(height: 5.h),

                // Age
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  text: AppDateUtils.formatAge(pet.birthdate),
                ),

                SizedBox(height: 5.h),

                // Requests
                _InfoRow(
                  icon: Icons.mail_outline,
                  text: '${pet.requestsCount} Requests',
                ),

                SizedBox(height: 12.h),

                // View Request Button
                Center(
                  child: SizedBox(
                    width: 176.w,
                    height: 38.h,

                    child: ElevatedButton(
                      onPressed: () {
                        context.router.push(
                          AdoptionRequestsRoute(
                            adoptionPostId: pet.adoptionPostId,
                            petName: pet.name,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primary50,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'View Request',
                        style: context.body2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PET IMAGE
// ============================================================================

class _PetImage extends StatelessWidget {
  final String? imageUrl;
  final String status;
  final String adoptionPostId;
  final VoidCallback onDelete;

  const _PetImage({
    required this.imageUrl,
    required this.status,
    required this.adoptionPostId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
      child: SizedBox(
        width: double.infinity,
        height: 195.h,
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return _placeholder(context);
                      },
                    )
                  : _placeholder(context),
            ),

            // Status
            // Positioned(
            //   top: 12.h,
            //   left: 10.w,
            //   child: _StatusBadge(status: status),
            // ),
            if (status.trim().isNotEmpty)
              Positioned(
                top: 12.h,
                left: 10.w,
                child: _StatusBadge(status: status),
              ),

            // Delete
            Positioned(
              top: 12.h,
              right: 10.w,
              child: _DeleteButton(onPressed: onDelete),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: context.neutral100,
      alignment: Alignment.center,
      child: Icon(Icons.pets, size: 55.r, color: context.primary),
    );
  }
}

// ============================================================================
// STATUS BADGE
// ============================================================================

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.trim().toLowerCase();

    final Color backgroundColor;
    final Color borderColor;
    final Color textColor;
    final String displayStatus;

    switch (normalizedStatus) {
      case 'pending':
      case 'available':
        backgroundColor = const Color(0xFFFFF8E8);
        borderColor = const Color(0xFFFFD36A);
        textColor = const Color(0xFF9E3E0A);
        displayStatus = 'Pending Adoption';
        break;

      case 'adopted':
        backgroundColor = const Color(0xFFEEF7FF);
        borderColor = const Color(0xFF8DC8FF);
        textColor = const Color(0xFF2457A6);
        displayStatus = 'Adopted';
        break;

      case 'cancelled':
        backgroundColor = const Color(0xFFFFEEEE);
        borderColor = const Color(0xFFFF8A8A);
        textColor = const Color(0xFFC62828);
        displayStatus = 'Cancelled';
        break;

      default:
        backgroundColor = Colors.white;
        borderColor = context.primary;
        textColor = context.primary;
        displayStatus = status.trim();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Text(
        displayStatus,
        style: context.body2.copyWith(
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   final displayStatus = status.trim();

  //   return Container(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: 12.w,
  //       vertical: 6.h,
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8.r),
  //       border: Border.all(
  //         color: context.primary,
  //       ),
  //     ),
  //     child: Text(
  //       displayStatus,
  //       style: context.body2.copyWith(
  //         fontWeight: FontWeight.w600,
  //         color: context.primary,
  //       ),
  //     ),
  //   );
}

// ============================================================================
// DELETE BUTTON
// ============================================================================

class _DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 25.r,
        height: 25.r,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Icon(Icons.close, color: Colors.white, size: 18.r),
      ),
    );
  }
}

// ============================================================================
// INFO ROW
// ============================================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: context.primary),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.body2.copyWith(color: context.neutral400),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// GENDER
// ============================================================================

class _GenderIcon extends StatelessWidget {
  const _GenderIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.r,
      height: 34.r,
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.female, size: 22.r, color: Colors.pinkAccent),
    );
  }
}
