import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Nearest only makes sense for Hotels (no lat/long on home_boarding_profiles)
/// and Most Experienced only for Home Boarding — each is left out of the
/// option list entirely for the tab it doesn't apply to.
Future<SortOption?> showSortFilterSheet({
  required BuildContext context,
  required SortOption current,
  required bool isHomeBoarding,
}) {
  final options = SortOption.values.where((option) {
    if (option == SortOption.nearest && isHomeBoarding) return false;
    if (option == SortOption.mostExperienced && !isHomeBoarding) return false;
    return true;
  }).toList();

  return showModalBottomSheet<SortOption>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _SortFilterSheet(options: options, current: current),
  );
}

class _SortFilterSheet extends StatelessWidget {
  const _SortFilterSheet({required this.options, required this.current});

  final List<SortOption> options;
  final SortOption current;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          12.h,
          16.w,
          16.h + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.neutral300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Sort & Filter',
              style: context.body1.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            for (final option in options)
              _OptionTile(option: option, selected: option == current),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.option, required this.selected});

  final SortOption option;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? context.primary100.withValues(alpha: 0.55)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () => Navigator.pop(context, option),
        child: SizedBox(
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option.label,
                    style: context.body2.copyWith(
                      color: selected
                          ? context.primary400
                          : context.neutral1000,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (selected)
                  Icon(
                    Icons.check_circle,
                    color: context.primary300,
                    size: 20.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
