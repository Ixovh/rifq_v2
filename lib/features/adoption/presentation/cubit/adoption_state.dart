part of 'adoption_cubit.dart';

class AdoptionState extends Equatable {
  final int selectedTabIndex;
  final String selectedCategory;

  // =========================
  // Get Adoption Pet Cards
  // =========================

  final bool isLoadingPosts;
  final List<AdoptionPetCardEntity> adoptionPetCards;

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

    // Get adoption pet cards
    this.isLoadingPosts = false,
    this.adoptionPetCards = const [],

    // Create post
    this.isCreatingPost = false,
    this.isPostCreated = false,
    this.createdPost,

    this.errorMessage,
  });

  AdoptionState copyWith({
    int? selectedTabIndex,
    String? selectedCategory,

    // Get adoption pet cards
    bool? isLoadingPosts,
    List<AdoptionPetCardEntity>? adoptionPetCards,

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

      // Get adoption pet cards
      isLoadingPosts:
          isLoadingPosts ?? this.isLoadingPosts,

      adoptionPetCards:
          adoptionPetCards ?? this.adoptionPetCards,

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
        adoptionPetCards,

        isCreatingPost,
        isPostCreated,
        createdPost,

        errorMessage,
      ];
}