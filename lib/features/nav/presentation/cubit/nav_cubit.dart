import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/home/presentation/screens/home_feature_screen.dart';
import 'package:rifq_v2/features/hotel/presentation/screens/hotel_list_screen.dart';
import 'package:rifq_v2/shared/presentation/widgets/coming_soon_placeholder.dart';

import 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  List<Widget> screens = [
    HomeScreen(),
    // ClinicScreen() — Health tab, not built yet; placeholder keeps index 2 = Hotel
    const ComingSoonPlaceholder(),
    HotelListScreen(),
    // AdoptionScreen(),
  ];
  int currentIndex = 0;
  bool isAiActive = false;

  NavCubit() : super(NavInitialState());

  void changeIndex({required int index}) {
    // Guard against tabs whose screen isn't implemented yet (see the
    // commented-out entries in `screens` above) — without this, tapping
    // Health/Hotel/Adoption sets an index the `screens` list doesn't have,
    // and `screens[currentIndex]` throws a RangeError on the next build.
    if (index < 0 || index >= screens.length) return;
    emit(NavLoadingState());
    currentIndex = index;
    emit(NavLoadedState());
  }

  @override
  Future<void> close() {
    //here is when close cubit
    return super.close();
  }

  void setAiActive() {
    isAiActive = true;
    emit(NavLoadedState());
  }

  void clearAiActive() {
    isAiActive = false;
    emit(NavLoadedState());
  }
}
