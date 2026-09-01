import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key, required this.isGuest, this.firstName});

  final bool isGuest;
  final String? firstName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final greetingStyle = context.h5.copyWith(
      color: context.neutral1000,
      fontWeight: FontWeight.w700,
    );
    final nameStyle = greetingStyle.copyWith(color: context.primary300);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: isGuest
          ? Text(l10n.home_welcome, style: greetingStyle)
          : Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: l10n.home_helloPrefix, style: greetingStyle),
                  TextSpan(
                    text: firstName ?? l10n.common_userFallback,
                    style: nameStyle,
                  ),
                ],
              ),
            ),
    );
  }
}
