import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Segmented "Hotels / Home Boarding" toggle + shared search bar + filter
/// icon from the Figma reference. Drives both tabs on the host list screen —
/// tapping a segment switches the visible list, tapping the search bar opens
/// the Search screen, tapping the filter icon opens the sort sheet.
class BoardingListToolbar extends StatelessWidget {
  const BoardingListToolbar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
    required this.onSearchTap,
    required this.onFilterTap,
  });

  final BoardingTab activeTab;
  final ValueChanged<BoardingTab> onTabChanged;
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: context.neutral200,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: _Segment(
                  label: 'Hotels',
                  selected: activeTab == BoardingTab.hotels,
                  onTap: () => onTabChanged(BoardingTab.hotels),
                ),
              ),
              Expanded(
                child: _Segment(
                  label: 'Home Boarding',
                  selected: activeTab == BoardingTab.homeBoarding,
                  onTap: () => onTabChanged(BoardingTab.homeBoarding),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30.r),
                  onTap: onSearchTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.neutral100,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: context.neutral200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: context.neutral500,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Search...',
                          style: context.body2.copyWith(
                            color: context.neutral500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Material(
              color: context.neutral100,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onFilterTap,
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.neutral200),
                  ),
                  child: Icon(Icons.tune, size: 18.sp, color: context.neutral500),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(26.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(26.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          alignment: Alignment.center,
          child: Text(
            label,
            style: context.body2.copyWith(
              color: selected ? context.primary300 : context.neutral500,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
