import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'l10n/cubit/locale_cubit.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/setup.dart';
import 'shared/service_locator/service_locator.dart';
import 'shared/presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  await configureDependencies();
  GoogleFonts.config.allowRuntimeFetching = false;

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    if (data.event == AuthChangeEvent.signedIn) {
      _appRouter.replaceAll([const NavWrapperRoute()]);
    }
  });

  runApp(const MainApp());
}

final _appRouter = AppRouter();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (_) => getIt<LocaleCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, _) {
          // Rebuilds MaterialApp with a new locale: whenever the language is
          // switched, so every AppLocalizations.of(context) below re-resolves
          // live — no restart.
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                routerConfig: _appRouter.config(),
                localizationsDelegates:
                    AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: localeState.locale,
                debugShowCheckedModeBanner: true,
              );
            },
          );
        },
      ),
    );
  }
}
