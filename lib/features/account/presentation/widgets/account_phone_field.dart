import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_text_field/helper/countries.dart';
import 'package:phone_text_field/phone_text_field.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AccountPhoneField extends StatefulWidget {
  const AccountPhoneField({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.initialCountryCode = 'SA',
    this.isRequired = false,
  });

  final ValueChanged<PhoneNumber> onChanged;
  final String? initialValue;
  final String initialCountryCode;
  final bool isRequired;

  @override
  State<AccountPhoneField> createState() => _AccountPhoneFieldState();
}

class _AccountPhoneFieldState extends State<AccountPhoneField> {
  late final TextEditingController _controller;
  late Country _country;
  late List<Country> _countries;

  @override
  void initState() {
    super.initState();
    CountriesHelper.init('en');
    _countries = List<Country>.from(countries)
      ..sort((a, b) => a.name.compareTo(b.name));

    _country = _countries.firstWhere(
      (c) => c.code == widget.initialCountryCode.toUpperCase(),
      orElse: () => _countries.first,
    );

    var number = '';
    final raw = widget.initialValue?.trim() ?? '';
    if (raw.isNotEmpty) {
      try {
        final parsed = PhoneNumber.fromCompleteNumber(completeNumber: raw);
        if (parsed.countryISOCode.isNotEmpty) {
          _country = _countries.firstWhere(
            (c) => c.code == parsed.countryISOCode,
            orElse: () => _country,
          );
          number = parsed.number;
        } else {
          number = raw.replaceFirst(RegExp(r'^\+'), '');
        }
      } catch (_) {
        number = raw.replaceFirst(RegExp(r'^\+'), '');
      }
    }

    _controller = TextEditingController(text: number);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PhoneNumber get _phoneNumber => PhoneNumber(
        countryISOCode: _country.code,
        countryCode: '+${_country.fullCountryCode}',
        number: _controller.text.trim(),
      );

  void _emit() => widget.onChanged(_phoneNumber);

  Future<void> _pickCountry() async {
    final selected = await showAccountCountryPickerSheet(
      context: context,
      countries: _countries,
      selected: _country,
    );
    if (selected == null || !mounted) return;
    setState(() => _country = selected);
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: _controller.text,
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) {
          return widget.isRequired
              ? AppLocalizations.of(context)!.account_phoneRequired
              : null;
        }
        if (text.length != 9) {
          return AppLocalizations.of(context)!.account_phoneInvalid9;
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 56.h,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10.w, right: 16.w),
                  decoration: BoxDecoration(
                    color: context.neutral100,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: field.hasError
                          ? context.error
                          : context.neutral200,
                    ),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: _pickCountry,
                        borderRadius: BorderRadius.circular(12.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _country.flag,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '+${_country.dialCode}',
                                style: context.body2.copyWith(
                                  color: context.neutral1000,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: context.neutral700,
                                size: 22.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 24.h,
                        color: context.neutral200,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                          onChanged: (value) {
                            field.didChange(value);
                            _emit();
                          },
                          style: context.body2.copyWith(
                            color: context.neutral1000,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 22.w,
                  top: -10.h,
                  child: Container(
                    color: context.neutral100,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      AppLocalizations.of(context)!.common_phoneNumber,
                      style: context.body2.copyWith(
                        color: context.neutral700,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: 6.h, left: 8.w),
                child: Text(
                  field.errorText!,
                  style: context.body3.copyWith(color: context.error),
                ),
              ),
          ],
        );
      },
    );
  }
}

Future<Country?> showAccountCountryPickerSheet({
  required BuildContext context,
  required List<Country> countries,
  required Country selected,
}) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _AccountCountryPickerSheet(
      countries: countries,
      selected: selected,
    ),
  );
}

class _AccountCountryPickerSheet extends StatefulWidget {
  const _AccountCountryPickerSheet({
    required this.countries,
    required this.selected,
  });

  final List<Country> countries;
  final Country selected;

  @override
  State<_AccountCountryPickerSheet> createState() =>
      _AccountCountryPickerSheetState();
}

class _AccountCountryPickerSheetState extends State<_AccountCountryPickerSheet> {
  late final TextEditingController _searchController;
  late List<Country> _filtered;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filtered = widget.countries;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    final query = value.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.countries;
        return;
      }
      final digitsOnly = RegExp(r'^\d+$').hasMatch(query);
      _filtered = widget.countries.where((country) {
        if (digitsOnly) {
          return country.dialCode.contains(query);
        }
        return country.name.toLowerCase().contains(query) ||
            country.code.toLowerCase().contains(query) ||
            country.dialCode.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height * 0.78;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        height: height,
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
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 18.h, 12.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.account_selectCountry,
                      style: context.h5.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: context.neutral1000,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.neutral700,
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                style: context.body2.copyWith(
                  color: context.neutral1000,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.account_searchCountry,
                  hintStyle: context.body2.copyWith(color: context.neutral500),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: context.neutral600,
                    size: 22.sp,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFBFCFF),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(color: context.neutral200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(color: context.neutral200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: context.primary300,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.account_noCountriesFound,
                        style: context.body2.copyWith(color: context.neutral700),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 24.h),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        color: context.neutral200.withValues(alpha: 0.7),
                      ),
                      itemBuilder: (context, index) {
                        final country = _filtered[index];
                        final isSelected =
                            country.code == widget.selected.code;

                        return InkWell(
                          onTap: () => Navigator.of(context).pop(country),
                          borderRadius: BorderRadius.circular(14.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.primary300.withValues(alpha: 0.08)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  country.flag,
                                  style: TextStyle(fontSize: 22.sp),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    country.name,
                                    style: context.body2.copyWith(
                                      color: context.neutral1000,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  '+${country.dialCode}',
                                  style: context.body2.copyWith(
                                    color: isSelected
                                        ? context.primary300
                                        : context.neutral700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.check_circle_rounded,
                                    color: context.primary300,
                                    size: 18.sp,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
