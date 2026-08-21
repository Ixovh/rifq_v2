import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/domain/repositories/home_repository_domain.dart';
import 'package:rifq_v2/features/home/domain/use_cases/home_use_case.dart';
import 'package:rifq_v2/features/home/presentation/cubit/home_cubit.dart';
import 'package:rifq_v2/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:rifq_v2/features/nav/presentation/screens/nav_screen.dart';

/// Stub repo so HomeCubit.loadHomeData() resolves instantly to a guest
/// state, without touching Supabase — the bug under test lives entirely in
/// NavCubit/NavScreen, HomeScreen is only along for the ride because
/// NavCubit.screens[0] is a hard-coded HomeScreen().
class _StubHomeRepoDomain implements HomeRepoDomain {
  @override
  Future<Result<HomeDataEntity, String>> getHomeData() async =>
      Success(HomeDataEntity(username: 'Guest', pets: const []));
}

Widget _wrap(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(402, 874),
    builder: (_, _) => MaterialApp(home: child),
  );
}

/// The bottom-bar tab icons don't carry a Key, and `find.text('Home')` is
/// ambiguous (the CustomAppBar title is also literally "Home"). Each tab's
/// icon asset path is unique per tab per selected/unselected state, so
/// locate the tappable GestureDetector via its icon image instead.
Finder _tabByIconAsset(String assetPath) => find.ancestor(
  of: find.image(AssetImage(assetPath)),
  matching: find.byType(GestureDetector),
);

void main() {
  setUp(() {
    GetIt.instance.registerFactory<HomeCubit>(
      () => HomeCubit(GetHomeDataUseCase(_StubHomeRepoDomain())),
    );
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  group('NavScreen bottom tab bar', () {
    testWidgets(
      'tapping the Home tab (index 0, the only implemented screen) does not throw',
      (tester) async {
        await tester.pumpWidget(
          _wrap(
            BlocProvider(create: (_) => NavCubit(), child: const NavScreen()),
          ),
        );
        await tester.pump();
        // Drain whatever the initial Guest-home render produced (a known,
        // pre-existing, unrelated GuestCard layout overflow + test-harness
        // "asset not found" noise from CarouselSlider — neither is fatal
        // and neither is what this test is about).
        tester.takeException();

        // currentIndex starts at 0, so Home is already selected -> the
        // "filled" icon variant is on screen.
        await tester.tap(_tabByIconAsset('assets/images/home-2f.png'));
        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
          reason: 'tapping the already-selected Home tab must not throw',
        );
      },
    );

    final tabs = {
      'Health': (index: 1, unselectedIcon: 'assets/images/heart-add.png'),
      'Hotel': (index: 2, unselectedIcon: 'assets/images/house-2.png'),
      'Adoption': (index: 3, unselectedIcon: 'assets/images/pet.png'),
    };

    for (final entry in tabs.entries) {
      testWidgets(
        'tapping the ${entry.key} tab (index ${entry.value.index}, not yet '
        'implemented) does not crash the app',
        (tester) async {
          await tester.pumpWidget(
            _wrap(
              BlocProvider(
                create: (_) => NavCubit(),
                child: const NavScreen(),
              ),
            ),
          );
          await tester.pump();
          // Same pre-existing, unrelated initial-render noise as above —
          // not what this test is checking.
          tester.takeException();

          await tester.tap(_tabByIconAsset(entry.value.unselectedIcon));
          await tester.pump();

          // Before the fix: NavCubit.screens only has one entry (index 0 =
          // HomeScreen), but the bottom bar lets you tap through to index
          // 1/2/3. NavScreen's `body: cubit.screens[cubit.currentIndex]`
          // then does a raw List index-out-of-range read, throwing an
          // uncaught RangeError that aborts the build — this is the
          // "tap a bottom-nav tab, uncaught exception, app hangs" bug.
          final exception = tester.takeException();
          expect(
            exception,
            isNull,
            reason:
                'Tapping a not-yet-implemented tab must not throw '
                '(got: $exception)',
          );
        },
      );
    }
  });
}
