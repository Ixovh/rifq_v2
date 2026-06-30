import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/features/nav/prsentaion/cubit/nav_cubit.dart';
import 'package:rifq_v2/features/nav/prsentaion/cubit/nav_state.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<NavCubit>();
        return BlocBuilder<NavCubit, NavState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: context.background,
              
              // 1. Move the button here
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: GestureDetector(
                onTap: () {
                  // context.push(Routes.aiScreen);
                  cubit.setAiActive();
                },
                child: Container(
                  // Add margin to lift it up if needed to match your previous 'bottom: 45.h'
                  // You might need to tweak this margin-bottom to get the exact position you had
                  margin: EdgeInsets.only(bottom: 10.h), 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.primary50,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4.sp,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/Vector(1).png',
                          height: 24.h,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Ask AI',
                        style: context.body3.copyWith(
                          color: context.primary50,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Clean up the BottomNavigationBar (Remove the Stack/Positioned)
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: context.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      top: 10.h,
                      bottom: 15.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Home
                        Flexible(
                          child: GestureDetector(
                            onTap: () => cubit.changeIndex(index: 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  cubit.currentIndex == 0
                                      ? 'assets/images/home-2f.png'
                                      : 'assets/images/home-2.png',
                                  height: 24.h,
                                  width: 24.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Home",
                                  style: cubit.currentIndex == 0
                                      ? context.body3.copyWith(
                                          color: context.primary50,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        )
                                      : context.body3.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Health
                        Flexible(
                          child: GestureDetector(
                            onTap: () => cubit.changeIndex(index: 1),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  cubit.currentIndex == 1
                                      ? 'assets/images/heart-addf.png'
                                      : 'assets/images/heart-add.png',
                                  height: 24.h,
                                  width: 24.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Health",
                                  style: cubit.currentIndex == 1
                                      ? context.body3.copyWith(
                                          color: context.primary50,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        )
                                      : context.body3.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Spacer for FAB
                        SizedBox(width: 50.w),
                        
                        // Hotel
                        Flexible(
                          child: GestureDetector(
                            onTap: () => cubit.changeIndex(index: 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  cubit.currentIndex == 2
                                      ? 'assets/images/house-2f.png'
                                      : 'assets/images/house-2.png',
                                  height: 24.h,
                                  width: 24.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Hotel",
                                  style: cubit.currentIndex == 2
                                      ? context.body3.copyWith(
                                          color: context.primary50,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        )
                                      : context.body3.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Adoption
                        Flexible(
                          child: GestureDetector(
                            onTap: () => cubit.changeIndex(index: 3),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  cubit.currentIndex == 3
                                      ? 'assets/images/petf.png'
                                      : 'assets/images/pet.png',
                                  height: 24.h,
                                  width: 24.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Adoption",
                                  style: cubit.currentIndex == 3
                                      ? context.body3.copyWith(
                                          color: context.primary50,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        )
                                      : context.body3.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              body: cubit.screens[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}



@RoutePage()
class NavWrapperScreen extends StatelessWidget {
  const NavWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: const NavScreen(),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:rifq/core/routes/base_routes.dart';
// import 'package:rifq/core/theme/app_theme.dart';
// import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_cubit.dart';
// import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_state.dart';

// class NavScreen extends StatelessWidget {
//   const NavScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         final cubit = context.read<NavCubit>();
//         return BlocBuilder<NavCubit, NavState>(
//           builder: (context, state) {
//             return Scaffold(
//               resizeToAvoidBottomInset: true, //عشان يثبت زر الai
//               backgroundColor: context.background,

//               floatingActionButton: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(width: 16),
//                   FloatingActionButton(
//                     elevation: 4,
//                     shape: const CircleBorder(),
//                     backgroundColor: context.primary50,
//                     onPressed: () {
//                       context.push(Routes.aiScreen);
//                       cubit.setAiActive();
//                     },
//                     child: Image.asset(
//                       'assets/images/Vector(1).png',
//                       height: 24,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     'Ask AI',
//                     style: context.body3.copyWith(
//                       color: context.primary50,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               floatingActionButtonLocation:
//                   FloatingActionButtonLocation.centerDocked,
//               floatingActionButtonAnimator:
//                   FloatingActionButtonAnimator.noAnimation,
//               bottomNavigationBar: BottomNavigationBar(
//                 backgroundColor: context.background,
//                 type: BottomNavigationBarType.fixed,
//                 currentIndex: cubit.currentIndex,

//                 onTap: (value) {
//                   cubit.changeIndex(index: value);
//                 },

//                 selectedItemColor: context.primary50,
//                 unselectedItemColor: Colors.grey,

//                 selectedLabelStyle: context.body3.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),

//                 unselectedLabelStyle: context.body3.copyWith(
//                   fontWeight: FontWeight.w400,
//                 ),

//                 items: [
//                   BottomNavigationBarItem(
//                     label: "Home",
//                     icon: Image.asset('assets/images/home-2.png', height: 24),
//                     activeIcon: Image.asset(
//                       'assets/images/home-2f.png',
//                       height: 24,
//                     ),
//                   ),

//                   BottomNavigationBarItem(
//                     label: "Health",
//                     icon: Image.asset(
//                       'assets/images/heart-add.png',
//                       height: 24,
//                     ),
//                     activeIcon: Image.asset(
//                       'assets/images/heart-addf.png',
//                       height: 24,
//                     ),
//                   ),
//                   BottomNavigationBarItem(
//                     label: "Hotel",
//                     icon: Image.asset('assets/images/house-2.png', height: 24),
//                     activeIcon: Image.asset(
//                       'assets/images/house-2f.png',
//                       height: 24,
//                     ),
//                   ),
//                   BottomNavigationBarItem(
//                     label: "Adoption",
//                     icon: Image.asset('assets/images/pet.png', height: 24),
//                     activeIcon: Image.asset(
//                       'assets/images/petf.png',
//                       height: 24,
//                     ),
//                   ),
//                 ],
//               ),

//               body: cubit.screens[cubit.currentIndex],
//             );
//           },
//         );
//       },
//     );
//   }
// }