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

Future<({DateTime start, DateTime end})?> showAppDateRangePicker({
  required BuildContext context,
  DateTime? initialStart,
  DateTime? initialEnd,
  String title = 'Choose dates',
  DateTime? firstDay,
  DateTime? lastDay,
}) {
  return showModalBottomSheet<({DateTime start, DateTime end})>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _AppDateRangePickerSheet(
      initialStart: initialStart,
      initialEnd: initialEnd,
      title: title,
      firstDay: firstDay ?? DateUtils.dateOnly(DateTime.now()),
      lastDay:
          lastDay ??
          DateUtils.dateOnly(DateTime.now()).add(const Duration(days: 365)),
    ),
  );
}

Future<DateTime?> showAppTimePicker({
  required BuildContext context,
  DateTime? initial,
  String title = 'Set time',
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _AppTimePickerSheet(initial: initial, title: title),
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

  late int _pickerYear;
  late int _pickerMonth;
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late final List<int> _years;

  @override
  void initState() {
    super.initState();
    final today = DateUtils.dateOnly(DateTime.now());
    final initial = widget.selectedDate != null
        ? DateUtils.dateOnly(widget.selectedDate!)
        : today;
    _selectedDay = _clampDay(initial);
    _focusedDay = _selectedDay;

    _years = [
      for (var y = widget.firstDay.year; y <= widget.lastDay.year; y++) y,
    ];
    _pickerYear = _focusedDay.year;
    _pickerMonth = _focusedDay.month;
    _yearController = FixedExtentScrollController();
    _monthController = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  DateTime get _firstDay => DateUtils.dateOnly(widget.firstDay);
  DateTime get _lastDay => DateUtils.dateOnly(widget.lastDay);

  DateTime _clampDay(DateTime day) {
    final first = _firstDay;
    final last = _lastDay;
    if (day.isBefore(first)) return first;
    if (day.isAfter(last)) return last;
    return day;
  }

  List<int> _monthsForYear(int year) {
    final months = <int>[];
    for (var m = 1; m <= 12; m++) {
      final start = DateTime(year, m);
      final end = DateTime(year, m + 1, 0);
      if (end.isBefore(_firstDay)) continue;
      if (start.isAfter(_lastDay)) continue;
      months.add(m);
    }
    return months.isEmpty ? [_focusedDay.month] : months;
  }

  void _openMonthYearPicker() {
    final months = _monthsForYear(_focusedDay.year);
    _pickerYear = _focusedDay.year;
    _pickerMonth = months.contains(_focusedDay.month)
        ? _focusedDay.month
        : months.last;

    _yearController.dispose();
    _monthController.dispose();
    _yearController = FixedExtentScrollController(
      initialItem: _years.indexOf(_pickerYear).clamp(0, _years.length - 1),
    );
    _monthController = FixedExtentScrollController(
      initialItem: months.indexOf(_pickerMonth).clamp(0, months.length - 1),
    );

    setState(() => _pickingMonthYear = true);
  }

  void _applyMonthYear() {
    final months = _monthsForYear(_pickerYear);
    final month = months.contains(_pickerMonth) ? _pickerMonth : months.last;
    final maxDay = DateUtils.getDaysInMonth(_pickerYear, month);
    final day = _selectedDay.day.clamp(1, maxDay);
    final jumped = _clampDay(DateTime(_pickerYear, month, day));

    setState(() {
      _focusedDay = DateTime(jumped.year, jumped.month, jumped.day);
      _selectedDay = jumped;
      _pickingMonthYear = false;
    });
  }

  void _onYearChanged(int index) {
    final nextYear = _years[index];
    final months = _monthsForYear(nextYear);
    final nextMonth = months.contains(_pickerMonth)
        ? _pickerMonth
        : months.last;
    final monthIndex = months.indexOf(nextMonth).clamp(0, months.length - 1);

    _monthController.dispose();
    _monthController = FixedExtentScrollController(initialItem: monthIndex);

    setState(() {
      _pickerYear = nextYear;
      _pickerMonth = nextMonth;
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
            Text(
              _pickingMonthYear ? 'Choose month' : widget.title,
              style: context.body1,
            ),
            SizedBox(height: 4.h),
            Text(
              _pickingMonthYear
                  ? DateFormat(
                      'MMMM yyyy',
                    ).format(DateTime(_pickerYear, _pickerMonth))
                  : DateFormat('EEEE, d MMMM yyyy').format(_selectedDay),
              style: context.body3.copyWith(color: context.primary300),
            ),
            SizedBox(height: 8.h),
            if (_pickingMonthYear)
              _buildMonthYearPicker(context)
            else
              _buildCalendar(context),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_pickingMonthYear) {
                    _applyMonthYear();
                    return;
                  }
                  Navigator.pop(context, _selectedDay);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary300,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  _pickingMonthYear ? 'Done' : 'Confirm',
                  style: context.body1.copyWith(color: Colors.white),
                ),
              ),
            ),
            if (_pickingMonthYear) ...[
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () => setState(() => _pickingMonthYear = false),
                child: Text(
                  'Back to calendar',
                  style: context.body2.copyWith(color: context.neutral600),
                ),
              ),
            ],
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return TableCalendar(
      key: ValueKey('cal_${_focusedDay.year}_${_focusedDay.month}'),
      firstDay: widget.firstDay,
      lastDay: widget.lastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      enabledDayPredicate: (day) {
        final d = DateUtils.dateOnly(day);
        return !d.isBefore(_firstDay) && !d.isAfter(_lastDay);
      },
      calendarFormat: CalendarFormat.month,
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        headerPadding: EdgeInsets.symmetric(vertical: 8.h),
        titleTextStyle: context.body1.copyWith(color: context.neutral1000),
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
          // Custom titles replace TableCalendar's default GestureDetector,
          // so the tap target must be wired here.
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _openMonthYearPicker,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(day),
                    style: context.body1.copyWith(color: context.neutral1000),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 14.sp,
                    color: context.primary300,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      onHeaderTapped: (_) => _openMonthYearPicker(),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: context.body3.copyWith(color: context.neutral600),
        weekendStyle: context.body3.copyWith(color: context.neutral600),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        defaultTextStyle: context.body2.copyWith(color: context.neutral1000),
        weekendTextStyle: context.body2.copyWith(color: context.neutral1000),
        disabledTextStyle: context.body2.copyWith(color: context.neutral400),
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
    );
  }

  Widget _buildMonthYearPicker(BuildContext context) {
    final months = _monthsForYear(_pickerYear);

    return SizedBox(
      height: 220.h,
      child: Row(
        children: [
          Expanded(
            child: CupertinoPicker(
              key: ValueKey('month_picker_$_pickerYear'),
              scrollController: _monthController,
              itemExtent: 40,
              magnification: 1.08,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                if (index < 0 || index >= months.length) return;
                setState(() => _pickerMonth = months[index]);
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
              itemExtent: 40,
              magnification: 1.08,
              useMagnifier: true,
              onSelectedItemChanged: _onYearChanged,
              children: [
                for (final y in _years)
                  Center(child: Text('$y', style: context.body2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppDateRangePickerSheet extends StatefulWidget {
  const _AppDateRangePickerSheet({
    this.initialStart,
    this.initialEnd,
    required this.title,
    required this.firstDay,
    required this.lastDay,
  });

  final DateTime? initialStart;
  final DateTime? initialEnd;
  final String title;
  final DateTime firstDay;
  final DateTime lastDay;

  @override
  State<_AppDateRangePickerSheet> createState() =>
      _AppDateRangePickerSheetState();
}

class _AppDateRangePickerSheetState extends State<_AppDateRangePickerSheet> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _rangeStart = widget.initialStart != null
        ? DateUtils.dateOnly(widget.initialStart!)
        : null;
    _rangeEnd = widget.initialEnd != null
        ? DateUtils.dateOnly(widget.initialEnd!)
        : null;
    _focusedDay = _rangeStart ?? DateUtils.dateOnly(DateTime.now());
  }

  bool get _canApply =>
      _rangeStart != null &&
      _rangeEnd != null &&
      _rangeEnd!.isAfter(_rangeStart!);

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
              _rangeStart == null
                  ? 'Select a date range'
                  : _rangeEnd == null
                  ? DateFormat('EEE, d MMM').format(_rangeStart!)
                  : '${DateFormat('EEE, d MMM').format(_rangeStart!)} - '
                        '${DateFormat('EEE, d MMM yyyy').format(_rangeEnd!)}',
              style: context.body3.copyWith(color: context.primary300),
            ),
            SizedBox(height: 8.h),
            TableCalendar(
              firstDay: widget.firstDay,
              lastDay: widget.lastDay,
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
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
                rangeHighlightColor: context.primary100.withValues(alpha: 0.5),
                rangeStartDecoration: BoxDecoration(
                  color: context.primary300,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: context.primary300,
                  shape: BoxShape.circle,
                ),
                rangeStartTextStyle: context.body2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                rangeEndTextStyle: context.body2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                withinRangeDecoration: BoxDecoration(
                  color: context.primary100.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                withinRangeTextStyle: context.body2.copyWith(
                  color: context.primary400,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start != null
                      ? DateUtils.dateOnly(start)
                      : null;
                  _rangeEnd = end != null ? DateUtils.dateOnly(end) : null;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focused) => setState(() => _focusedDay = focused),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: _canApply
                    ? () => Navigator.pop(context, (
                        start: _rangeStart!,
                        end: _rangeEnd!,
                      ))
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary300,
                  disabledBackgroundColor: context.primary100,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: context.body1.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => setState(() {
                _rangeStart = null;
                _rangeEnd = null;
              }),
              child: Text(
                'Reset',
                style: context.body2.copyWith(color: context.neutral600),
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}

class _AppTimePickerSheet extends StatefulWidget {
  const _AppTimePickerSheet({this.initial, required this.title});

  final DateTime? initial;
  final String title;

  @override
  State<_AppTimePickerSheet> createState() => _AppTimePickerSheetState();
}

class _AppTimePickerSheetState extends State<_AppTimePickerSheet> {
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial ?? DateTime.now();
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
            SizedBox(height: 12.h),
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: _selected,
                use24hFormat: false,
                onDateTimeChanged: (value) => _selected = value,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selected),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary300,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Save',
                  style: context.body1.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: context.body2.copyWith(color: context.neutral600),
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
