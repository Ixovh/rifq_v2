// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rifq_v2/features/onboarding/domain/use_cases/onboarding_use_case.dart';
// import 'package:rifq_v2/features/onboarding/presentation/cubit/onboarding_state.dart';

// class OnboardingCubit extends Cubit<OnboardingState> {
//   final OnboardingUseCase _onboardingUseCase;

//   OnboardingCubit(this._onboardingUseCase) : super(OnboardingInitialState());

//   Future<void> getOnboardingMethod() async {
//     final result = await _onboardingUseCase.getOnboarding();
//     result.when(
//       (success) {
//         //here is when success result
//       },
//       (whenError) {
//        //here is when error result
//       },
//     );
//   }

//   @override
//   Future<void> close() {
//     //here is when close cubit
//     return super.close();
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void nextPage() {
    if (state < 2) emit(state + 1);
  }

  void skip() {
    emit(2);
  }

  void changePage(int index) {
    emit(index);
  }
}