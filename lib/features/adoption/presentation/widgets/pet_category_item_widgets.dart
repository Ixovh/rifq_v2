// import 'package:flutter/material.dart';
// import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

// class PetCategoryItem extends StatelessWidget {
//   const PetCategoryItem({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//     required this.isSelected,
//     required this.onTap,
//   });

//   final String title;
//   final String imageUrl;
//   final bool isSelected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             width: 48,
//             height: 32,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 4,
//             ),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? colorScheme.primary.withValues(alpha: 0.15)
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   radius: 11,
//                   backgroundImage: NetworkImage(imageUrl),
//                 ),
//                 if (isSelected) ...[
//                   const SizedBox(width: 3),
//                   Flexible(
//                     child: Text(
//                       title,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: context.primary,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),

//           if (!isSelected) ...[
//             const SizedBox(height: 4),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class PetCategoryItem extends StatelessWidget {
  const PetCategoryItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 48.h,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 7.w),

            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : context.neutral500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}