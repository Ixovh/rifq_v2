// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/doption_request_card.dart';

// @RoutePage()
// class AdoptionRequestsScreen extends StatefulWidget {
//   final String adoptionPostId;
//   final String petName;

//   const AdoptionRequestsScreen({
//     super.key,
//     required this.adoptionPostId,
//     required this.petName,
//   });

//   @override
//   State<AdoptionRequestsScreen> createState() =>
//       _AdoptionRequestsScreenState();
// }

// class _AdoptionRequestsScreenState extends State<AdoptionRequestsScreen> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AdoptionCubit>().getAdoptionRequests(
//             adoptionPostId: widget.adoptionPostId,
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),

//             SizedBox(height: 25.h),

//             Expanded(
//               child: BlocBuilder<AdoptionCubit, AdoptionState>(
//                 builder: (context, state) {
//                   if (state.isLoadingAdoptionRequests) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }

//                   if (state.errorMessage != null &&
//                       state.adoptionRequests.isEmpty) {
//                     return Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 30.w),
//                         child: Text(
//                           state.errorMessage!,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                   }

//                   if (state.adoptionRequests.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No adoption requests yet',
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     );
//                   }

//                   return ListView.separated(
//                     padding: EdgeInsets.fromLTRB(
//                       20.w,
//                       0,
//                       20.w,
//                       30.h,
//                     ),
//                     itemCount: state.adoptionRequests.length,
//                     separatorBuilder: (_, __) => SizedBox(height: 18.h),
//                     itemBuilder: (context, index) {
//                       final request = state.adoptionRequests[index];

//                       return AdoptionRequestCard(
//                         request: request,
//                         isUpdating: state.isUpdatingRequest,
//                         onAccept: () {
//                           context
//                               .read<AdoptionCubit>()
//                               .updateAdoptionRequestStatus(
//                                 requestId: request.id,
//                                 adoptionPostId: request.adoptionPostId,
//                                 status: 'accepted',
//                               );
//                         },
//                         onReject: () {
//                           context
//                               .read<AdoptionCubit>()
//                               .updateAdoptionRequestStatus(
//                                 requestId: request.id,
//                                 adoptionPostId: request.adoptionPostId,
//                                 status: 'rejected',
//                               );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 20.w,
//         right: 20.w,
//         top: 15.h,
//       ),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: Icon(
//               Icons.arrow_back,
//               size: 30.sp,
//               color: Colors.black87,
//             ),
//           ),

//           Expanded(
//             child: Center(
//               child: Text(
//                 'Adoption requests – ${widget.petName}',
//                 style: TextStyle(
//                   fontSize: 21.sp,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(width: 30.w),
//         ],
//       ),
//     );
//   }
// }




import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/doption_request_card.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';

@RoutePage()
class AdoptionRequestsScreen extends StatelessWidget {
  final String adoptionPostId;
  final String petName;

  const AdoptionRequestsScreen({
    super.key,
    required this.adoptionPostId,
    required this.petName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdoptionCubit>()
        ..getAdoptionRequests(
          adoptionPostId: adoptionPostId,
        ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),

              SizedBox(height: 25.h),

              Expanded(
                child: BlocBuilder<AdoptionCubit, AdoptionState>(
                  builder: (context, state) {
                    // =========================
                    // Loading
                    // =========================

                    if (state.isLoadingAdoptionRequests) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // =========================
                    // Error
                    // =========================

                    if (state.errorMessage != null &&
                        state.adoptionRequests.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                          ),
                          child: Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    // =========================
                    // Empty
                    // =========================

                    if (state.adoptionRequests.isEmpty) {
                      return Center(
                        child: Text(
                          'No adoption requests yet',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    // =========================
                    // Requests
                    // =========================

                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        20.w,
                        0,
                        20.w,
                        30.h,
                      ),
                      itemCount: state.adoptionRequests.length,
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 18.h);
                      },
                      itemBuilder: (context, index) {
                        final request =
                            state.adoptionRequests[index];

                        return AdoptionRequestCard(
                          request: request,
                          isUpdating: state.isUpdatingRequest,

                          // =========================
                          // Accept
                          // =========================

                          onAccept: () async {
                            final cubit = context.read<AdoptionCubit>();
                            await cubit.updateAdoptionRequestStatus(
                              requestId: request.id,
                              adoptionPostId: request.adoptionPostId,
                              status: 'accepted',
                            );

                            if (!context.mounted) return;
                            if (cubit.state.errorMessage != null) {
                              context.showErrorToast(cubit.state.errorMessage!);
                              return;
                            }

                            context.showSuccessToast(
                              'Request accepted. The pet was transferred to the adopter.',
                            );
                          },

                          // =========================
                          // Reject
                          // =========================

                          onReject: () {
                            context
                                .read<AdoptionCubit>()
                                .updateAdoptionRequestStatus(
                                  requestId: request.id,
                                  adoptionPostId:
                                      request.adoptionPostId,
                                  status: 'rejected',
                                );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 15.h,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.router.pop();
            },
            child: Icon(
              Icons.arrow_back,
              size: 30.sp,
              color: Colors.black87,
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                'Adoption requests – $petName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          SizedBox(width: 30.sp),
        ],
      ),
    );
  }
}