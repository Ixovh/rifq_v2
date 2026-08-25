import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:table_calendar/table_calendar.dart';

const otherSpecies = <({String value, String label, IconData icon})>[
  (value: 'bird', label: 'Bird', icon: Icons.flutter_dash_outlined),
  (value: 'falcon', label: 'Falcon', icon: Icons.air),
  (value: 'rabbit', label: 'Rabbit', icon: Icons.cruelty_free_outlined),
  (value: 'fish', label: 'Fish', icon: Icons.water),
  (value: 'turtle', label: 'Turtle', icon: Icons.spa_outlined),
  (value: 'hamster', label: 'Hamster', icon: Icons.pets_outlined),
  (value: 'pigeon', label: 'Pigeon', icon: Icons.flutter_dash),
  (value: 'horse', label: 'Horse', icon: Icons.agriculture_outlined),
  (value: 'other', label: 'Other', icon: Icons.more_horiz),
];

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  DateTime? selectedDate,
  String title = 'Choose date',
  DateTime? firstDay,
  DateTime? lastDay,
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _AppDatePickerSheet(
      selectedDate: selectedDate,
      title: title,
      firstDay: firstDay ?? DateTime(2000),
      lastDay: lastDay ?? DateUtils.dateOnly(DateTime.now()),
    ),
  );
}

Future<String?> showAppSpeciesSheet({
  required BuildContext context,
  required String selectedSpecies,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _AppSpeciesSheet(selectedSpecies: selectedSpecies),
  );
}

class _SheetChrome extends StatelessWidget {
  const _SheetChrome({required this.child});

  final Widget child;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.neutral300,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _AppDatePickerSheet extends StatefulWidget {
  const _AppDatePickerSheet({
    this.selectedDate,
    required this.title,
    required this.firstDay,
    required this.lastDay,
  });

  final DateTime? selectedDate;
  final String title;
  final DateTime firstDay;
  final DateTime lastDay;

  @override
  State<_AppDatePickerSheet> createState() => _AppDatePickerSheetState();
}

class _AppDatePickerSheetState extends State<_AppDatePickerSheet> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  var _pickingMonthYear = false;

  @override
  void initState() {
    super.initState();
    final today = DateUtils.dateOnly(DateTime.now());
    final initial = widget.selectedDate != null
        ? DateUtils.dateOnly(widget.selectedDate!)
        : today;
    _selectedDay = _clampDay(initial);
    _focusedDay = _selectedDay;
  }

  DateTime _clampDay(DateTime day) {
    final first = DateUtils.dateOnly(widget.firstDay);
    final last = DateUtils.dateOnly(widget.lastDay);
    if (day.isBefore(first)) return first;
    if (day.isAfter(last)) return last;
    return day;
  }

  Future<void> _openMonthYearPicker() async {
    setState(() => _pickingMonthYear = true);

    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (_) => _MonthYearPickerSheet(
        initialDate: _focusedDay,
        firstDay: widget.firstDay,
        lastDay: widget.lastDay,
      ),
    );

    if (!mounted) return;
    setState(() {
      _pickingMonthYear = false;
      if (picked != null) {
        _focusedDay = DateTime(picked.year, picked.month);
        // Keep day if still valid in the new month, else clamp.
        final dayInMonth = DateTime(
          picked.year,
          picked.month,
          _selectedDay.day.clamp(
            1,
            DateUtils.getDaysInMonth(picked.year, picked.month),
          ),
        );
        if (!dayInMonth.isAfter(widget.lastDay) &&
            !dayInMonth.isBefore(widget.firstDay)) {
          _selectedDay = dayInMonth;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SheetChrome(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title, style: context.body1),
            SizedBox(height: 4.h),
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(_selectedDay),
              style: context.body3.copyWith(color: context.primary300),
            ),
            SizedBox(height: 8.h),
            TableCalendar(
              firstDay: widget.firstDay,
              lastDay: widget.lastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              enabledDayPredicate: (day) {
                final d = DateUtils.dateOnly(day);
                return !d.isBefore(DateUtils.dateOnly(widget.firstDay)) &&
                    !d.isAfter(DateUtils.dateOnly(widget.lastDay));
              },
              calendarFormat: CalendarFormat.month,
              availableGestures: AvailableGestures.horizontalSwipe,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                headerPadding: EdgeInsets.symmetric(vertical: 8.h),
                titleTextStyle: context.body1.copyWith(
                  color: context.neutral1000,
                ),
                leftChevronIcon: Icon(
                  CupertinoIcons.chevron_left,
                  size: 18.sp,
                  color: context.primary300,
                ),
                rightChevronIcon: Icon(
                  CupertinoIcons.chevron_right,
                  size: 18.sp,
                  color: context.primary300,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(day),
                        style: context.body1.copyWith(
                          color: context.neutral1000,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        CupertinoIcons.chevron_down,
                        size: 14.sp,
                        color: context.primary300,
                      ),
                    ],
                  );
                },
              ),
              onHeaderTapped: (_) {
                if (!_pickingMonthYear) _openMonthYearPicker();
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: context.body3.copyWith(color: context.neutral600),
                weekendStyle: context.body3.copyWith(color: context.neutral600),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                defaultTextStyle: context.body2.copyWith(
                  color: context.neutral1000,
                ),
                weekendTextStyle: context.body2.copyWith(
                  color: context.neutral1000,
                ),
                disabledTextStyle: context.body2.copyWith(
                  color: context.neutral400,
                ),
                todayDecoration: BoxDecoration(
                  color: context.primary100,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: context.body2.copyWith(
                  color: context.primary500,
                  fontWeight: FontWeight.w600,
                ),
                selectedDecoration: BoxDecoration(
                  color: context.primary300,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: context.body2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              onPageChanged: (focused) => setState(() => _focusedDay = focused),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selectedDay),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary300,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: context.body1.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}

class _MonthYearPickerSheet extends StatefulWidget {
  const _MonthYearPickerSheet({
    required this.initialDate,
    required this.firstDay,
    required this.lastDay,
  });

  final DateTime initialDate;
  final DateTime firstDay;
  final DateTime lastDay;

  @override
  State<_MonthYearPickerSheet> createState() => _MonthYearPickerSheetState();
}

class _MonthYearPickerSheetState extends State<_MonthYearPickerSheet> {
  late int _year;
  late int _month;
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;

  late final List<int> _years;

  @override
  void initState() {
    super.initState();
    _year = widget.initialDate.year;
    _month = widget.initialDate.month;
    _years = [
      for (var y = widget.firstDay.year; y <= widget.lastDay.year; y++) y,
    ];
    _yearController = FixedExtentScrollController(
      initialItem: (_years.indexOf(_year)).clamp(0, _years.length - 1),
    );
    _monthController = FixedExtentScrollController(
      initialItem: (_availableMonths.indexOf(
        _month,
      )).clamp(0, _availableMonths.length - 1),
    );
  }

  List<int> get _availableMonths {
    final months = <int>[];
    for (var m = 1; m <= 12; m++) {
      final start = DateTime(_year, m);
      final end = DateTime(_year, m + 1, 0);
      if (end.isBefore(DateUtils.dateOnly(widget.firstDay))) continue;
      if (start.isAfter(DateUtils.dateOnly(widget.lastDay))) continue;
      months.add(m);
    }
    return months.isEmpty ? [widget.initialDate.month] : months;
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  void _onYearChanged(int index) {
    final nextYear = _years[index];
    setState(() {
      _year = nextYear;
      final months = _availableMonths;
      if (!months.contains(_month)) {
        _month = months.last;
      }
      final monthIndex = months.indexOf(_month).clamp(0, months.length - 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_monthController.hasClients) {
          _monthController.jumpToItem(monthIndex);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final months = _availableMonths;

    return _SheetChrome(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose month', style: context.body1),
            SizedBox(height: 4.h),
            Text(
              DateFormat('MMMM yyyy').format(DateTime(_year, _month)),
              style: context.body3.copyWith(color: context.primary300),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 180.h,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: _monthController,
                      itemExtent: 40.h,
                      onSelectedItemChanged: (index) {
                        setState(() => _month = months[index]);
                      },
                      children: [
                        for (final m in months)
                          Center(
                            child: Text(
                              DateFormat('MMMM').format(DateTime(2000, m)),
                              style: context.body2,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: _yearController,
                      itemExtent: 40.h,
                      onSelectedItemChanged: _onYearChanged,
                      children: [
                        for (final y in _years)
                          Center(child: Text('$y', style: context.body2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pop(context, DateTime(_year, _month)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary300,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: context.body1.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}

class _AppSpeciesSheet extends StatelessWidget {
  const _AppSpeciesSheet({required this.selectedSpecies});

  final String selectedSpecies;

  bool _isSelected(String value) =>
      selectedSpecies == value &&
      selectedSpecies.isNotEmpty &&
      selectedSpecies != 'cat' &&
      selectedSpecies != 'dog';

  @override
  Widget build(BuildContext context) {
    return _SheetChrome(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select pet type', style: context.body1),
            SizedBox(height: 4.h),
            Text(
              'Another common pets',
              style: context.body3.copyWith(color: context.neutral600),
            ),
            SizedBox(height: 16.h),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 420.h),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: otherSpecies.length,
                separatorBuilder: (_, _) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final option = otherSpecies[index];
                  final selected = _isSelected(option.value);
                  return Material(
                    color: selected
                        ? context.primary100.withValues(alpha: 0.55)
                        : context.neutral100,
                    borderRadius: BorderRadius.circular(16.r),
                    child: InkWell(
                      onTap: () => Navigator.pop(context, option.value),
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        height: 56.h,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: selected
                                ? context.primary300
                                : context.neutral200,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: selected
                                    ? context.primary300
                                    : context.primary100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                option.icon,
                                size: 18.sp,
                                color: selected
                                    ? Colors.white
                                    : context.primary400,
                              ),
                            ),
                            SizedBox(width: 12.w),
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
                  );
                },
              ),
            ),
            SizedBox(height: 12.h + MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}
