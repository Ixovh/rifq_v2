import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_post_use_case.dart';
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_posts_use_case.dart';

part 'adoption_state.dart';

@injectable
class AdoptionCubit extends Cubit<AdoptionState> {
  final CreateAdoptionPostUseCase _createAdoptionPostUseCase;
  final FetchAdoptionPostsUseCase _fetchAdoptionPostsUseCase;

  AdoptionCubit(
    this._createAdoptionPostUseCase,
    this._fetchAdoptionPostsUseCase,
  ) : super(const AdoptionState());

  // =========================
  // UI
  // =========================

  void changeTab(int index) {
    emit(
      state.copyWith(
        selectedTabIndex: index,
      ),
    );
  }

  void selectCategory(String category) {
    emit(
      state.copyWith(
        selectedCategory: category,
      ),
    );
  }

  // =========================
  // Get Adoption Posts
  // =========================

Future<void> getAdoptionPosts() async {
  emit(
    state.copyWith(
      isLoadingPosts: true,
      errorMessage: null,
    ),
  );

  final result = await _fetchAdoptionPostsUseCase();

  result.when(
    (posts) {
      final uniquePosts = <String, AdoptionPostEntity>{};

      for (final post in posts) {
        uniquePosts[post.petId] = post;
      }

      emit(
        state.copyWith(
          isLoadingPosts: false,
          adoptionPosts: uniquePosts.values.toList(),
        ),
      );
    },
    (error) {
      emit(
        state.copyWith(
          isLoadingPosts: false,
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

    final result = await _createAdoptionPostUseCase(
      adoptionPost: adoptionPost,
    );

    result.when(
      (post) {
        emit(
          state.copyWith(
            isCreatingPost: false,
            isPostCreated: true,
            createdPost: post,
          ),
        );

        // بعد إنشاء الإعلان، نحدث القائمة
        getAdoptionPosts();
      },
      (error) {
        emit(
          state.copyWith(
            isCreatingPost: false,
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