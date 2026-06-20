import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/adoption_use_case.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  final AdoptionUseCase _adoptionUseCase;

  AdoptionCubit(this._adoptionUseCase) : super(AdoptionInitialState());

  Future<void> getAdoptionMethod() async {
    final result = await _adoptionUseCase.getAdoption();
    result.when(
      (success) {
        //here is when success result
      },
      (whenError) {
       //here is when error result
      },
    );
  }

  @override
  Future<void> close() {
    //here is when close cubit
    return super.close();
  }
}
