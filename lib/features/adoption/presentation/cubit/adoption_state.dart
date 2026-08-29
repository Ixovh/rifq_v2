part of 'adoption_cubit.dart';

class AdoptionState extends Equatable {
  final int selectedTabIndex;
  final String selectedCategory;

  // =========================
  // Get Adoption Posts
  // =========================

  final bool isLoadingPosts;
  final List<AdoptionPostEntity> adoptionPosts;

  // =========================
  // Create Adoption Post
  // =========================

  final bool isCreatingPost;
  final bool isPostCreated;
  final AdoptionPostEntity? createdPost;

  final String? errorMessage;

  const AdoptionState({
    this.selectedTabIndex = 0,
    this.selectedCategory = 'Cat',

    // Get posts
    this.isLoadingPosts = false,
    this.adoptionPosts = const [],

    // Create post
    this.isCreatingPost = false,
    this.isPostCreated = false,
    this.createdPost,

    this.errorMessage,
  });

  AdoptionState copyWith({
    int? selectedTabIndex,
    String? selectedCategory,

    // Get posts
    bool? isLoadingPosts,
    List<AdoptionPostEntity>? adoptionPosts,

    // Create post
    bool? isCreatingPost,
    bool? isPostCreated,
    AdoptionPostEntity? createdPost,

    String? errorMessage,
  }) {
    return AdoptionState(
      selectedTabIndex:
          selectedTabIndex ?? this.selectedTabIndex,

      selectedCategory:
          selectedCategory ?? this.selectedCategory,

      // Get posts
      isLoadingPosts:
          isLoadingPosts ?? this.isLoadingPosts,

      adoptionPosts:
          adoptionPosts ?? this.adoptionPosts,

      // Create post
      isCreatingPost:
          isCreatingPost ?? this.isCreatingPost,

      isPostCreated:
          isPostCreated ?? this.isPostCreated,

      createdPost:
          createdPost ?? this.createdPost,

      errorMessage:
          errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedTabIndex,
        selectedCategory,

        isLoadingPosts,
        adoptionPosts,

        isCreatingPost,
        isPostCreated,
        createdPost,

        errorMessage,
      ];
}