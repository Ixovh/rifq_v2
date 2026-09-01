// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rifq_v2/features/adoption/presentation/widgets/pet_category_item_widgets.dart';
// import '../cubit/adoption_cubit.dart';

// class PetCategoriesSection extends StatelessWidget {
//   const PetCategoriesSection({
//     super.key,
//     this.onMoreCategoryTap,
//   });

//   final VoidCallback? onMoreCategoryTap;

//   static const categories = [
//     (
//       title: 'Cat',
//       imageUrl:
//           'https://images.unsplash.com/photo-1518791841217-8f162f1e1131',
//     ),
//     (
//       title: 'Dog',
//       imageUrl:
//           'https://images.unsplash.com/photo-1552053831-71594a27632d',
//     ),
//     (
//       title: 'Turtle',
//       imageUrl:
//           'https://images.unsplash.com/photo-1504976375718-3f3e4296ef1c',
//     ),
//     (
//       title: 'Rabbit',
//       imageUrl:
//           'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AdoptionCubit, AdoptionState>(
//       buildWhen: (previous, current) =>
//           previous.selectedCategory != current.selectedCategory,
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Pet Categories',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   const Spacer(),
//                   TextButton(
//                     onPressed: onMoreCategoryTap,
//                     child: const Text(
//                       'More Category',
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 8),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: categories.map((category) {
//                   return PetCategoryItem(
//                     title: category.title,
//                     imageUrl: category.imageUrl,
//                     isSelected:
//                         state.selectedCategory == category.title,
//                     onTap: () {
//                       context
//                           .read<AdoptionCubit>()
//                           .selectCategory(category.title);
//                     },
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/pet_category_item_widgets.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';

class PetCategoriesSection extends StatelessWidget {
  const PetCategoriesSection({
    super.key,
    this.onMoreCategoryTap,
  });

  final VoidCallback? onMoreCategoryTap;

  static const categories = [
    (
      value: 'cat',
      imagePath: 'assets/images/icons8-cat-64.png',
    ),
    (
      value: 'dog',
      imagePath: 'assets/images/icons8-dog-64.png',
    ),
    (
      value: 'turtle',
      imagePath: 'assets/images/icons8-turtell-64.png',
    ),
    (
      value: 'rabbit',
      imagePath: 'assets/images/icons8-Rabbit-64.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      buildWhen: (previous, current) =>
          previous.selectedCategory != current.selectedCategory,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -----------------------------
              // Section Header
              // -----------------------------
              Row(
                children: [
                  Text(
                    l10n.adoption_petCategories,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: context.neutral500,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: onMoreCategoryTap,
                    child: Text(
                      l10n.adoption_moreCategories,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: context.neutral400,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // -----------------------------
              // Categories
              // -----------------------------
              SizedBox(
                height: 48.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(
                    width: 12.w,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return PetCategoryItem(
                      title: speciesLabel(context, category.value),
                      imagePath: category.imagePath,
                      isSelected:
                          state.selectedCategory == category.value,
                      onTap: () {
                        context
                            .read<AdoptionCubit>()
                            .selectCategory(category.value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}