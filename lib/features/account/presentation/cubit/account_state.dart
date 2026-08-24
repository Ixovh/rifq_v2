part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountGuestState extends AccountState {}

class AccountLoadedState extends AccountState {
  final AccountDataEntity data;

  const AccountLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AccountUpdatingState extends AccountState {
  final AccountDataEntity data;

  const AccountUpdatingState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AccountUpdateSuccessState extends AccountState {
  final AccountDataEntity data;
  final bool emailConfirmationPending;
  final String? pendingEmail;

  const AccountUpdateSuccessState({
    required this.data,
    this.emailConfirmationPending = false,
    this.pendingEmail,
  });

  @override
  List<Object?> get props => [data, emailConfirmationPending, pendingEmail];
}

class AccountLogoutSuccessState extends AccountState {}

class AccountErrorState extends AccountState {
  final String msg;

  const AccountErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
