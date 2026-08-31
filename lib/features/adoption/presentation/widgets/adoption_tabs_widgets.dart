import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';


class AdoptionTabs extends StatelessWidget {
  const AdoptionTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AdoptionCubit, AdoptionState>(
      buildWhen: (previous, current) =>
          previous.selectedTabIndex != current.selectedTabIndex,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                _TabItem(
                  title: 'For Adoption',
                  isSelected: state.selectedTabIndex == 0,
                  onTap: () {
                    context.read<AdoptionCubit>().changeTab(0);
                  },
                ),
                _TabItem(
                  title: 'My Pets',
                  isSelected: state.selectedTabIndex == 1,
                  onTap: () {
                    context.read<AdoptionCubit>().changeTab(1);
                  },
                ),
              ],
            ),
            Container(
              height: 1,
              color: colorScheme.outline.withValues(
                alpha: 0.2,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: isSelected
                    ? context.primary
                    : Colors.transparent,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? context.primary
                      : colorScheme.onSurface.withValues(
                          alpha: 0.55,
                        ),
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}