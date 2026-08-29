// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
// import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_post_use_case.dart';

// part 'adoption_state.dart';

// class AdoptionCubit extends Cubit<AdoptionState> {
//   final CreateAdoptionPostUseCase _createAdoptionPostUseCase;

//   AdoptionCubit(
//     this._createAdoptionPostUseCase,
//   ) : super(const AdoptionState());

//   // =========================
//   // UI
//   // =========================

//   void changeTab(int index) {
//     emit(
//       state.copyWith(
//         selectedTabIndex: index,
//       ),
//     );
//   }

//   void selectCategory(String category) {
//     emit(
//       state.copyWith(
//         selectedCategory: category,
//       ),
//     );
//   }

//   // =========================
//   // Create Adoption Post
//   // =========================

//   Future<void> createAdoptionPost({
//     required AdoptionPostEntity adoptionPost,
//   }) async {
//     emit(
//       state.copyWith(
//         isCreatingPost: true,
//         errorMessage: null,
//         isPostCreated: false,
//       ),
//     );

//     final result = await _createAdoptionPostUseCase(
//       adoptionPost: adoptionPost,
//     );

//     result.when(
//       (post) {
//         emit(
//           state.copyWith(
//             isCreatingPost: false,
//             isPostCreated: true,
//             createdPost: post,
//           ),
//         );
//       },
//       (error) {
//         emit(
//           state.copyWith(
//             isCreatingPost: false,
//             errorMessage: error.toString(),
//           ),
//         );
//       },
//     );
//   }

//   void resetCreatePostState() {
//     emit(
//       state.copyWith(
//         isCreatingPost: false,
//         isPostCreated: false,
//         createdPost: null,
//         errorMessage: null,
//       ),
//     );
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';

import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_post_use_case.dart';

part 'adoption_state.dart';

@injectable
class AdoptionCubit extends Cubit<AdoptionState> {
  final CreateAdoptionPostUseCase _createAdoptionPostUseCase;

  AdoptionCubit(
    this._createAdoptionPostUseCase,
  ) : super(const AdoptionState());

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
}
