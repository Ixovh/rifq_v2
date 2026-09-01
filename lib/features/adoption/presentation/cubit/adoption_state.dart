part of 'adoption_cubit.dart';

class AdoptionState extends Equatable {
  final int selectedTabIndex;
  final String selectedCategory;

  // =========================
  // Get Adoption Pet Cards
  // =========================

  final bool isLoadingPosts;
  final List<AdoptionPetCardEntity> adoptionPetCards;
  final List<AdoptionPetCardEntity> allAdoptionPetCards;
  // =========================
  // Create Adoption Post
  // =========================

  final bool isCreatingPost;
  final bool isPostCreated;
  final AdoptionPostEntity? createdPost;

  final String? errorMessage;
  final bool isLoadingMyAdoptionPets;
  final List<MyAdoptionPetEntity> myAdoptionPets;
  final bool isLoadingAdoptionRequests;
  final List<AdoptionRequestCardEntity> adoptionRequests;
  final bool isUpdatingRequest;

  final bool isDeletingPost;

  const AdoptionState({
    this.selectedTabIndex = 0,
    this.selectedCategory = 'Cat',
    this.allAdoptionPetCards = const [],
    this.adoptionPetCards = const [],
    // Get adoption pet cards
    this.isLoadingPosts = false,

    // Get adoption pet details
    this.isLoadingPetDetails = false,
    this.petDetails,

    // Create post
    this.isCreatingPost = false,
    this.isPostCreated = false,
    this.createdPost,

    this.errorMessage,
    this.isCreatingRequest = false,
    this.isRequestCreated = false,
    this.createdRequest,
    this.isLoadingMyAdoptionPets = false,
    this.myAdoptionPets = const [],
    this.isDeletingPost = false,
    this.isLoadingAdoptionRequests = false,
    this.adoptionRequests = const [],
    this.isUpdatingRequest = false,
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
    // Get adoption pet details
    bool? isLoadingPetDetails,
    AdoptionPetDetailsEntity? petDetails,

    String? errorMessage,
    List<AdoptionPetCardEntity>? allAdoptionPetCards,

    bool? isCreatingRequest,
    bool? isRequestCreated,
    AdoptionRequestEntity? createdRequest,
    bool? isLoadingMyAdoptionPets,
    List<MyAdoptionPetEntity>? myAdoptionPets,
    bool? isDeletingPost,
    bool? isLoadingAdoptionRequests,
    List<AdoptionRequestCardEntity>? adoptionRequests,
    bool? isUpdatingRequest,
  }) {
    return AdoptionState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,

      selectedCategory: selectedCategory ?? this.selectedCategory,

      // Get adoption pet cards
      isLoadingPosts: isLoadingPosts ?? this.isLoadingPosts,

      adoptionPetCards: adoptionPetCards ?? this.adoptionPetCards,

      // Get adoption pet details
      isLoadingPetDetails: isLoadingPetDetails ?? this.isLoadingPetDetails,

      petDetails: petDetails ?? this.petDetails,

      // Create post
      isCreatingPost: isCreatingPost ?? this.isCreatingPost,

      isPostCreated: isPostCreated ?? this.isPostCreated,

      createdPost: createdPost ?? this.createdPost,

      errorMessage: errorMessage,
      allAdoptionPetCards: allAdoptionPetCards ?? this.allAdoptionPetCards,
      isCreatingRequest: isCreatingRequest ?? this.isCreatingRequest,

      isRequestCreated: isRequestCreated ?? this.isRequestCreated,

      createdRequest: createdRequest ?? this.createdRequest,
      isLoadingMyAdoptionPets:
          isLoadingMyAdoptionPets ?? this.isLoadingMyAdoptionPets,

      myAdoptionPets: myAdoptionPets ?? this.myAdoptionPets,
      isDeletingPost: isDeletingPost ?? this.isDeletingPost,
      isLoadingAdoptionRequests:
          isLoadingAdoptionRequests ?? this.isLoadingAdoptionRequests,

      adoptionRequests: adoptionRequests ?? this.adoptionRequests,

      isUpdatingRequest: isUpdatingRequest ?? this.isUpdatingRequest,
    );
  }

  // =========================
  // Get Pet Details
  // =========================
  final bool isLoadingPetDetails;
  final AdoptionPetDetailsEntity? petDetails;

  //
  final bool isCreatingRequest;
  final bool isRequestCreated;
  final AdoptionRequestEntity? createdRequest;

  @override
  List<Object?> get props => [
    selectedTabIndex,
    selectedCategory,

    isLoadingPosts,
    adoptionPetCards,

    isLoadingPetDetails,
    petDetails,

    isCreatingPost,
    isPostCreated,
    createdPost,

    errorMessage,
    allAdoptionPetCards,
    adoptionPetCards,
    isCreatingRequest,
    isRequestCreated,
    createdRequest,
    isLoadingMyAdoptionPets,
    myAdoptionPets,
    isDeletingPost,

    isLoadingAdoptionRequests,
    adoptionRequests,
    isUpdatingRequest,
  ];
}
