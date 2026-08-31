import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_post_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_request_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_pet_details_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_posts_use_case.dart';

part 'adoption_state.dart';

@injectable
class AdoptionCubit extends Cubit<AdoptionState> {
  final CreateAdoptionPostUseCase _createAdoptionPostUseCase;
  final FetchAdoptionPetCardsUseCase _fetchAdoptionPetCardsUseCase;
  final FetchAdoptionPetDetailsUseCase _fetchAdoptionPetDetailsUseCase;
  final CreateAdoptionRequestUseCase _createAdoptionRequestUseCase;

  AdoptionCubit(
    this._createAdoptionPostUseCase,
    this._fetchAdoptionPetCardsUseCase,
    this._fetchAdoptionPetDetailsUseCase,
    this._createAdoptionRequestUseCase,
  ) : super(const AdoptionState());

  // =========================
  // UI
  // =========================

  void changeTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  // void selectCategory(String category) {
  //   emit(
  //     state.copyWith(
  //       selectedCategory: category,
  //     ),
  //   );
  // }
  void selectCategory(String category) {
    final filteredPets = state.allAdoptionPetCards.where((pet) {
      return pet.species?.toLowerCase() == category.toLowerCase();
    }).toList();

    emit(
      state.copyWith(
        selectedCategory: category,
        adoptionPetCards: filteredPets,
      ),
    );
  }

  // =========================
  // Get Adoption Pet Cards
  // =========================

  Future<void> getAdoptionPetCards() async {
    emit(state.copyWith(isLoadingPosts: true, errorMessage: null));

    final result = await _fetchAdoptionPetCardsUseCase();

    result.when(
      (cards) {
        final filteredPets = cards.where((pet) {
          return pet.species?.toLowerCase() ==
              state.selectedCategory.toLowerCase();
        }).toList();

        emit(
          state.copyWith(
            isLoadingPosts: false,
            allAdoptionPetCards: cards,
            adoptionPetCards: filteredPets,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(isLoadingPosts: false, errorMessage: error.toString()),
        );
      },
    );
  }

  // =========================
  // Get Adoption Pet Details
  // =========================

  Future<void> getAdoptionPetDetails({required String adoptionPostId}) async {
    emit(state.copyWith(isLoadingPetDetails: true, errorMessage: null));

    final result = await _fetchAdoptionPetDetailsUseCase(
      adoptionPostId: adoptionPostId,
    );

    result.when(
      (details) {
        emit(
          state.copyWith(
            isLoadingPetDetails: false,
            petDetails: details,
            errorMessage: null,
            
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            isLoadingPetDetails: false,
            errorMessage: error.toString(),
          ),
        );
      },
    );
  }

  // =========================
  // Create Adoption Post
  // =========================
  Future<void> createAdoptionPost({
    required AdoptionPostEntity adoptionPost,
  }) async {
    emit(
      state.copyWith(
        isCreatingPost: true,
        errorMessage: null,
        isPostCreated: false,
      ),
    );

    final result = await _createAdoptionPostUseCase(adoptionPost: adoptionPost);

    result.when(
      (post) {
        emit(
          state.copyWith(
            isCreatingPost: false,
            isPostCreated: true,
            createdPost: post,
          ),
        );

        // لا نحط getAdoptionPetCards هنا
      },
      (error) {
        emit(
          state.copyWith(isCreatingPost: false, errorMessage: error.toString()),
        );
      },
    );
  }
  Future<void> createAdoptionRequest({
  required AdoptionRequestEntity adoptionRequest,
}) async {
  emit(
    state.copyWith(
      isCreatingRequest: true,
      isRequestCreated: false,
      errorMessage: null,
    ),
  );

  final result = await _createAdoptionRequestUseCase(
    adoptionRequest: adoptionRequest,
  );

  result.when(
    (request) {
      emit(
        state.copyWith(
          isCreatingRequest: false,
          isRequestCreated: true,
          createdRequest: request,
          errorMessage: null,
        ),
      );
    },
    (error) {
      emit(
        state.copyWith(
          isCreatingRequest: false,
          isRequestCreated: false,
          errorMessage: error.toString(),
        ),
      );
    },
  );
}

  // =========================
  // Reset Create Post State
  // =========================

  void resetCreatePostState() {
    emit(
      state.copyWith(
        isCreatingPost: false,
        isPostCreated: false,
        createdPost: null,
        errorMessage: null,
      ),
    );
  }
}
