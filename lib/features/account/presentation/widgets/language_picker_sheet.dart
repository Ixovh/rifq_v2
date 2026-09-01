import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/cubit/locale_cubit.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Bottom sheet that switches the app language via [LocaleCubit].
///
/// [context] must sit under the root `BlocProvider<LocaleCubit>` (from
/// `main.dart`); the cubit is captured before the sheet opens and handed to
/// the sheet with `BlocProvider.value`.
Future<void> showLanguagePickerSheet(BuildContext context) {
  final localeCubit = context.read<LocaleCubit>();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => BlocProvider.value(
      value: localeCubit,
      child: const _LanguagePickerSheet(),
    ),
  );
}

class _LanguagePickerSheet extends StatelessWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.neutral300,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.account_language,
              textAlign: TextAlign.center,
              style: context.body1.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                final current = state.locale.languageCode;
                return Column(
                  children: [
                    for (final language in LanguagesEnum.values)
                      _LanguageRow(
                        label: switch (language) {
                          LanguagesEnum.en => l10n.language_english,
                          LanguagesEnum.ar => l10n.language_arabic,
                        },
                        selected: language.name == current,
                        onTap: () {
                          context.read<LocaleCubit>().changeLocale(
                            language: language,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
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
      color: selected
          ? context.primary100.withValues(alpha: 0.55)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: SizedBox(
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: context.body2.copyWith(
                      color: selected
                          ? context.primary400
                          : context.neutral1000,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
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
