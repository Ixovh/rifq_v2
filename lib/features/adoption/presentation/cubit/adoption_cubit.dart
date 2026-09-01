import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/my_adoption_pet_entity.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_post_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_request_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/delete_adoption_post_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_pet_details_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_posts_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_requests_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_my_adoption_pet_cards_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_my_adoption_request_status_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/update_adoption_request_status_use_case.dart';

part 'adoption_state.dart';

@injectable
class AdoptionCubit extends Cubit<AdoptionState> {
  final CreateAdoptionPostUseCase _createAdoptionPostUseCase;
  final FetchAdoptionPetCardsUseCase _fetchAdoptionPetCardsUseCase;
  final FetchAdoptionPetDetailsUseCase _fetchAdoptionPetDetailsUseCase;
  final CreateAdoptionRequestUseCase _createAdoptionRequestUseCase;
  final FetchMyAdoptionPetCardsUseCase _fetchMyAdoptionPetCardsUseCase;
  final DeleteAdoptionPostUseCase _deleteAdoptionPostUseCase;
  final FetchAdoptionRequestsUseCase _fetchAdoptionRequestsUseCase;
  final UpdateAdoptionRequestStatusUseCase _updateAdoptionRequestStatusUseCase;
  final FetchMyAdoptionRequestStatusUseCase _fetchMyAdoptionRequestStatusUseCase;

  AdoptionCubit(
    this._createAdoptionPostUseCase,
    this._fetchAdoptionPetCardsUseCase,
    this._fetchAdoptionPetDetailsUseCase,
    this._createAdoptionRequestUseCase,
    this._fetchMyAdoptionPetCardsUseCase,
    this._deleteAdoptionPostUseCase,
    this._fetchAdoptionRequestsUseCase,
    this._updateAdoptionRequestStatusUseCase,
    this._fetchMyAdoptionRequestStatusUseCase,
  ) : super(const AdoptionState());

  // =========================
  // UI
  // =========================

void changeTab(int index) {
  emit(state.copyWith(selectedTabIndex: index));

  if (index == 1) {
    getMyAdoptionPets();
  } else {
    getAdoptionPetCards();
  }
}

  Future<void> refreshCurrentTab() async {
    if (state.selectedTabIndex == 1) {
      await getMyAdoptionPets(silent: true);
    } else {
      await getAdoptionPetCards(silent: true);
    }
  }

  Future<void> getMyAdoptionPets({bool silent = false}) async {
  emit(
    state.copyWith(
      isLoadingMyAdoptionPets: silent ? state.isLoadingMyAdoptionPets : true,
      errorMessage: null,
    ),
  );

  final result = await _fetchMyAdoptionPetCardsUseCase();

  result.when(
    (pets) {
      emit(
        state.copyWith(
          isLoadingMyAdoptionPets: false,
          myAdoptionPets: pets,
          errorMessage: null,
        ),
      );
    },
    (error) {
      emit(
        state.copyWith(
          isLoadingMyAdoptionPets: false,
          errorMessage: error.toString(),
        ),
      );
    },
  );
}


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

  Future<void> getAdoptionPetCards({bool silent = false}) async {
    emit(
      state.copyWith(
        isLoadingPosts: silent ? state.isLoadingPosts : true,
        errorMessage: null,
      ),
    );

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
    final myStatusResult = await _fetchMyAdoptionRequestStatusUseCase(
      adoptionPostId: adoptionPostId,
    );

    String? myRequestStatus;
    myStatusResult.when(
      (status) => myRequestStatus = status,
      (_) {},
    );

    result.when(
      (details) {
        emit(
          state.copyWith(
            isLoadingPetDetails: false,
            petDetails: details,
            myRequestStatus: myRequestStatus,
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
        getMyAdoptionPets(silent: true);
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
            myRequestStatus: request.status,
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

Future<void> deleteAdoptionPost({
  required String adoptionPostId,
}) async {
  emit(
    state.copyWith(
      isDeletingPost: true,
      errorMessage: null,
    ),
  );

  try {
    await _deleteAdoptionPostUseCase(
      adoptionPostId: adoptionPostId,
    );

    final updatedPets = state.myAdoptionPets
        .where(
          (pet) => pet.adoptionPostId != adoptionPostId,
        )
        .toList();
    final updatedCards = state.adoptionPetCards
        .where(
          (pet) => pet.adoptionPostId != adoptionPostId,
        )
        .toList();
    final updatedAllCards = state.allAdoptionPetCards
        .where(
          (pet) => pet.adoptionPostId != adoptionPostId,
        )
        .toList();

    emit(
      state.copyWith(
        isDeletingPost: false,
        myAdoptionPets: updatedPets,
        adoptionPetCards: updatedCards,
        allAdoptionPetCards: updatedAllCards,
        errorMessage: null,
      ),
    );
  } catch (error) {
    emit(
      state.copyWith(
        isDeletingPost: false,
        errorMessage: error.toString(),
      ),
    );
  }
}

Future<void> getAdoptionRequests({
  required String adoptionPostId,
}) async {
  emit(
    state.copyWith(
      isLoadingAdoptionRequests: true,
      errorMessage: null,
    ),
  );

  final result = await _fetchAdoptionRequestsUseCase(
    adoptionPostId: adoptionPostId,
  );

  result.when(
    (requests) {
      emit(
        state.copyWith(
          isLoadingAdoptionRequests: false,
          adoptionRequests: requests,
          errorMessage: null,
        ),
      );
    },
    (error) {
      emit(
        state.copyWith(
          isLoadingAdoptionRequests: false,
          errorMessage: error.toString(),
        ),
      );
    },
  );
}
//Accept / Reject
Future<void> updateAdoptionRequestStatus({
  required String requestId,
  required String adoptionPostId,
  required String status,
}) async {
  emit(
    state.copyWith(
      isUpdatingRequest: true,
      errorMessage: null,
    ),
  );

  final result = await _updateAdoptionRequestStatusUseCase(
    requestId: requestId,
    adoptionPostId: adoptionPostId,
    status: status,
  );

  result.when(
    (_) {
      final updatedRequests = state.adoptionRequests.map((request) {
        if (request.id == requestId) {
          return AdoptionRequestCardEntity(
            id: request.id,
            adoptionPostId: request.adoptionPostId,
            requesterId: request.requesterId,
            fullName: request.fullName,
            avatarUrl: request.avatarUrl,
            phoneNumber: request.phoneNumber,
            location: request.location,
            message: request.message,
            experience: request.experience,
            status: status,
            createdAt: request.createdAt,
          );
        }

        if (status == 'accepted' &&
            request.status.toLowerCase() == 'pending') {
          return AdoptionRequestCardEntity(
            id: request.id,
            adoptionPostId: request.adoptionPostId,
            requesterId: request.requesterId,
            fullName: request.fullName,
            avatarUrl: request.avatarUrl,
            phoneNumber: request.phoneNumber,
            location: request.location,
            message: request.message,
            experience: request.experience,
            status: 'rejected',
            createdAt: request.createdAt,
          );
        }

        return request;
      }).toList();

      emit(
        state.copyWith(
          isUpdatingRequest: false,
          adoptionRequests: updatedRequests,
          errorMessage: null,
        ),
      );
    },
    (error) {
      emit(
        state.copyWith(
          isUpdatingRequest: false,
          errorMessage: error.toString(),
        ),
      );
    },
  );
}
  
}
