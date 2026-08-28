// import 'package:flutter/material.dart';
// import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

// class AdoptionHeader extends StatelessWidget {
//   const AdoptionHeader({
//     super.key,
//     this.onNotificationTap,
//   });

//   final VoidCallback? onNotificationTap;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 12,
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: colorScheme.primary.withValues(
//                 alpha: 0.12,
//               ),
//               border: Border.all(
//                 color: colorScheme.primary.withValues(
//                   alpha: 0.4,
//                 ),
//               ),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               'S',
//               style: TextStyle(
//                 color: context.primary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),

//           const Spacer(),

//           Text(
//             'Adoption',
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: context.primary50
//                 ),
//           ),

//           const Spacer(),

//           IconButton(
//             onPressed: onNotificationTap,
//             icon: Icon(
//               Icons.notifications_none_rounded,
//             color: context.primary50
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AdoptionHeader extends StatelessWidget {
  const AdoptionHeader({
    super.key,
    this.onNotificationTap,
  });

  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha: 0.10),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Profile
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.primary.withValues(alpha: 0.12),
              border: Border.all(
                color: context.primary,
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'S',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: context.primary,
              ),
            ),
          ),

          const Spacer(),

          // Title
          Text(
            'Adoption',
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.w600,
              color: context.primary50,
            ),
          ),

          const Spacer(),

          // Notification
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onNotificationTap,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  minWidth: 40.w,
                  minHeight: 40.w,
                ),
                icon: Icon(
                  Icons.notifications_none_rounded,
                  size: 32.sp,
                  color: context.primary50,
                ),
              ),

              // Notification dot
              Positioned(
                right: 2.w,
                top: 1.h,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}