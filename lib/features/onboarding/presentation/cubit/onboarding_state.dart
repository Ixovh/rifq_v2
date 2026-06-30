// import 'package:equatable/equatable.dart';

// abstract class OnboardingState extends Equatable {
//   const OnboardingState();

//   @override
//   List<Object?> get props => [];
// }

// class OnboardingInitialState extends OnboardingState {}
// class OnboardingSuccessState extends OnboardingState {}

// class OnboardingErrorState extends OnboardingState {
//   final String message;
//   const OnboardingErrorState({required this.message});
//   @override
//   List<Object?> get props => [message];
// }


part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}


