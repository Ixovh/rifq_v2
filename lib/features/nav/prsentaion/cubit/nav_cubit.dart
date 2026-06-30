import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/home/presentation/pages/home_feature_screen.dart';


import 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  List<Widget> screens = [
    HomeScreen(),
    // ClinicScreen(),
    // HotelHomeScreen(),
    // AdoptionScreen(),
  ];
  int currentIndex = 0;
  bool isAiActive = false;

  NavCubit() : super(NavInitialState());

  void changeIndex({required int index}) {
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