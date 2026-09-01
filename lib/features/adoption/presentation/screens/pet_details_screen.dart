import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';
@RoutePage()
class PetDetailsScreen extends StatelessWidget {
  final AdoptionPetCardEntity pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AdoptionCubit>()
            ..getAdoptionPetDetails(adoptionPostId: pet.adoptionPostId),
      child: _PetDetailsView(pet: pet),
    );
  }
}

class _PetDetailsView extends StatelessWidget {
  final AdoptionPetCardEntity pet;

  const _PetDetailsView({required this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      builder: (context, state) {
        // Loading
        if (state.isLoadingPetDetails) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Error
        if (state.errorMessage != null && state.petDetails == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Pet Details')),
            body: Center(child: Text(state.errorMessage!)),
          );
        }

        // No data
        final details = state.petDetails;

        if (details == null) {
          return const Scaffold(
            body: Center(child: Text('No pet details available')),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              _buildImageSection(context, details.imageUrl),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(28.w, 0, 28.w, 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),

                      Text(
                        details.name ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF5F5F5F),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      _detailRow(
                        icon: Icons.location_on_outlined,
                        text: details.location?.isNotEmpty == true
                            ? details.location!
                            : 'Not available',
                      ),

                      SizedBox(height: 9.h),

                      _detailRow(
                        icon: Icons.calendar_month_outlined,
                        text: details.birthdate != null
                            ? _formatAge(details.birthdate!)
                            : 'Not available',
                      ),

                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          _infoBox(
                            value: details.gender ?? 'Not available',
                            label: 'Gender',
                          ),
                          _infoBox(
                            value: details.breed ?? 'Not available',
                            label: 'Breed',
                          ),
                          _infoBox(
                            value:
                                details.weight?.toString() ?? 'Not available',
                            label: 'Weight',
                          ),
                        ],
                      ),

                      SizedBox(height: 25.h),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 31.r,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage:
                                details.ownerAvatarUrl != null &&
                                    details.ownerAvatarUrl!.isNotEmpty
                                ? NetworkImage(details.ownerAvatarUrl!)
                                : null,
                            child:
                                details.ownerAvatarUrl == null ||
                                    details.ownerAvatarUrl!.isEmpty
                                ? Icon(
                                    Icons.person,
                                    color: Colors.grey.shade500,
                                    size: 30.r,
                                  )
                                : null,
                          ),

                          SizedBox(width: 12.w),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Owner by:',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                details.ownerName ?? 'Pet Owner',
                                style: TextStyle(
                                  color: const Color(0xFF5F5F5F),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              if (details.ownerPhone != null &&
                                  details.ownerPhone!.isNotEmpty) ...[
                                SizedBox(height: 4.h),

                                Text(
                                  details.ownerPhone!,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 25.h),

                      Text(
                        details.description?.isNotEmpty == true
                            ? details.description!
                            : 'No description available.',
                        style: TextStyle(
                          color: details.description?.isNotEmpty == true
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                          fontSize: 16.sp,
                          height: 1.55,
                        ),
                      ),

                      SizedBox(height: 30.h),

                      SizedBox(
                        width: double.infinity,
                        height: 58.h,
                        child: ElevatedButton(
                          onPressed: state.myRequestStatus == 'pending'
                              ? null
                              : () {
                                  context.router.push(
                                    AdoptionFormRoute(
                                      adoptionPostId: pet.adoptionPostId,
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF36B8AB),
                            disabledBackgroundColor: const Color(
                              0xFF36B8AB,
                            ).withValues(alpha: 0.45),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            state.myRequestStatus == 'pending'
                                ? 'Request pending'
                                : state.myRequestStatus == 'rejected'
                                ? 'Request again'
                                : 'Adopt',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection(BuildContext context, String? imageUrl) {
    return SizedBox(
      height: 390.h,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 390.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return _imagePlaceholder();
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return _imagePlaceholder();
                    },
                  )
                : _imagePlaceholder(),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 12.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () {
                context.router.pop();
              },
              child: Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 27.r),
              ),
            ),
          ),

          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            child: Container(
              height: 28.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      alignment: Alignment.center,
      child: Icon(Icons.pets, size: 75.r, color: const Color(0xFF36B8AB)),
    );
  }

  Widget _infoBox({required String value, required String label}) {
    return Expanded(
      child: Container(
        height: 84.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEAEAEA)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF36B8AB),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF36B8AB), size: 21.r),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 15.sp),
          ),
        ),
      ],
    );
  }

  String _formatAge(DateTime birthdate) {
    final now = DateTime.now();

    int years = now.year - birthdate.year;

    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      years--;
    }

    if (years < 0) {
      years = 0;
    }

    if (years == 0) {
      final months =
          (now.year - birthdate.year) * 12 + now.month - birthdate.month;

      if (months <= 0) {
        return 'Less than 1 month';
      }

      return months == 1 ? '1 month' : '$months months';
    }

    return years == 1 ? '1 year' : '$years years';
  }
}
