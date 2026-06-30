import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/add_pet/data/models/pet_model.dart';
import 'package:rifq_v2/features/home/domain/use_cases/home_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase useCase;

  HomeCubit(this.useCase,) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    final result = await useCase.getHomeData();
      result.when(
      (data) {
        if (data.pets.isEmpty && data.username != "Guest") {
          emit(HomeEmptyState(data.username));
        } else if (data.username == "Guest") {
          emit(HomeGuestState());
        } else {
          emit(HomeLoadedState(
            username: data.username,
            pets: data.pets,
          ));
        }
      },
      (error) => emit(HomeError(error)),
    );
  }
}