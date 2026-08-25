import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/pet_category_item_widgets.dart';
import '../cubit/adoption_cubit.dart';

class PetCategoriesSection extends StatelessWidget {
  const PetCategoriesSection({
    super.key,
    this.onMoreCategoryTap,
  });

  final VoidCallback? onMoreCategoryTap;

  static const categories = [
    (
      title: 'Cat',
      imageUrl:
          'https://images.unsplash.com/photo-1518791841217-8f162f1e1131',
    ),
    (
      title: 'Dog',
      imageUrl:
          'https://images.unsplash.com/photo-1552053831-71594a27632d',
    ),
    (
      title: 'Turtle',
      imageUrl:
          'https://images.unsplash.com/photo-1504976375718-3f3e4296ef1c',
    ),
    (
      title: 'Rabbit',
      imageUrl:
          'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      buildWhen: (previous, current) =>
          previous.selectedCategory != current.selectedCategory,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Pet Categories',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: onMoreCategoryTap,
                    child: const Text(
                      'More Category',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories.map((category) {
                  return PetCategoryItem(
                    title: category.title,
                    imageUrl: category.imageUrl,
                    isSelected:
                        state.selectedCategory == category.title,
                    onTap: () {
                      context
                          .read<AdoptionCubit>()
                          .selectCategory(category.title);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}