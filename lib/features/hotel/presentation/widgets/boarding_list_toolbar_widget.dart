import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          height: 58.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: context.neutral200,
            borderRadius: BorderRadius.circular(250.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 1.9,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _Segment(
                  label: l10n.hotel_tabHotels,
                  selected: activeTab == BoardingTab.hotels,
                  onTap: () => onTabChanged(BoardingTab.hotels),
                ),
              ),
              Expanded(
                child: _Segment(
                  label: l10n.hotel_tabHomeBoarding,
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
                  borderRadius: BorderRadius.circular(18.r),
                  onTap: onSearchTap,
                  child: Container(
                    height: 46.h,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 1.9,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: const Color(0xFFA8A8A8),
                          size: 24.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          l10n.common_searchHint,
                          style: context.body2.copyWith(
                            color: const Color(0xFFA8A8A8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: onFilterTap,
                child: Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 1.9,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.tune,
                    size: 24.sp,
                    color: context.neutral500,
                  ),
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
      borderRadius: BorderRadius.circular(250.r),
      elevation: selected ? 1 : 0,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(250.r),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: context.body2.copyWith(
              color: selected ? context.primary300 : context.neutral600,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
