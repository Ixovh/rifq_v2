import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/core/theme/app_color.dart';

class CustomeContainerWidgets extends StatelessWidget{
  final String title;
  final String subTitle;
  final int pageIndex;
  final PageController controller;

  const CustomeContainerWidgets({
    super.key, required this.title,
    required this.subTitle,
    required this.pageIndex,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      height: 425.h,
      padding: EdgeInsets.only(
        top: 28.w,
        right: 18.w,
        bottom: 40.w,
        left: 18.w,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50),)
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                int currentIndex = controller.page?.round() ?? 0;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    bool isActive = currentIndex == index;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: isActive ? 22.w : 18.w,
                            height: isActive ? 22.w : 18.w,
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primary200 : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: AppColors.primary200),
                            ),
                          ),
                          if (isActive)
                            Image.asset(
                              'assets/images/streamline solid.png',
                              width: 14.w,
                              height: 14.w,
                            ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
            Text(title,style: TextStyle(color: AppColors.neutral900,fontSize:32.sp,fontWeight: FontWeight.w500)),
            SizedBox(height: 18.h),
            Text(subTitle,textAlign: TextAlign.center,style: TextStyle(color: AppColors.neutral800,fontSize:18.sp,fontWeight: FontWeight.w400)),
            SizedBox(height: 24.h,),
          ],

    )));


  }
}


