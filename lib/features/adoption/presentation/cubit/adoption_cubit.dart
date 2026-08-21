import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/fetch_adoption_posts_use_case.dart';
import '../../domain/use_cases/create_adoption_post_use_case.dart';
import 'adoption_state.dart';

@injectable
class AdoptionCubit extends Cubit<AdoptionState> {
  final FetchAdoptionPostsUseCase _fetchAdoptionPostsUseCase;
  final CreateAdoptionPostUseCase _createAdoptionPostUseCase;

  AdoptionCubit(
    this._fetchAdoptionPostsUseCase,
    this._createAdoptionPostUseCase,
  ) : super(const AdoptionState.initial());

  Future<void> loadAdoptionFeed() async {
    emit(const AdoptionState.loading());
    try {
      final posts = await _fetchAdoptionPostsUseCase.call();
      emit(AdoptionState.feedLoaded(posts));
    } catch (e) {
      emit(AdoptionState.error(e.toString()));
    }
  }

  Future<void> createPost({
    required String petName,
    required String species,
    required String breed,
    required int age,
    required String gender,
    String? healthStatusSummary,
    required String description,
    required String location,
    required List<File> imageFiles,
  }) async {
    emit(const AdoptionState.loading());
    try {
      await _createAdoptionPostUseCase.call(
        petName: petName,
        species: species,
        breed: breed,
        age: age,
        gender: gender,
        healthStatusSummary: healthStatusSummary,
        description: description,
        location: location,
        imageFiles: imageFiles,
      );
      emit(const AdoptionState.actionSuccess());
      
  
      await loadAdoptionFeed(); 
    } catch (e) {
      emit(AdoptionState.error(e.toString()));
    }
  }
}