part of 'adoption_cubit.dart';

class AdoptionState extends Equatable {
  final int selectedTabIndex;
  final String selectedCategory;

  // Create adoption post
  final bool isCreatingPost;
  final bool isPostCreated;
  final AdoptionPostEntity? createdPost;
  final String? errorMessage;

  const AdoptionState({
    this.selectedTabIndex = 0,
    this.selectedCategory = 'Cat',
    this.isCreatingPost = false,
    this.isPostCreated = false,
    this.createdPost,
    this.errorMessage,
  });

  AdoptionState copyWith({
    int? selectedTabIndex,
    String? selectedCategory,
    bool? isCreatingPost,
    bool? isPostCreated,
    AdoptionPostEntity? createdPost,
    String? errorMessage,
  }) {
    return AdoptionState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isCreatingPost: isCreatingPost ?? this.isCreatingPost,
      isPostCreated: isPostCreated ?? this.isPostCreated,
      createdPost: createdPost ?? this.createdPost,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedTabIndex,
        selectedCategory,
        isCreatingPost,
        isPostCreated,
        createdPost,
        errorMessage,
      ];
}