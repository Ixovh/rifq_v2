import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/domain/use_cases/account_use_case.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';

part 'account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  final AccountUseCase _accountUseCase;

  final editFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  AccountCubit(this._accountUseCase) : super(AccountInitial());

  Future<void> loadAccount() async {
    emit(AccountLoading());

    if (AuthHelper.isGuestUser()) {
      emit(AccountGuestState());
      return;
    }

    (await _accountUseCase.getAccountData()).when(
      (data) {
        _populateEditControllers(data);
        emit(AccountLoadedState(data: data));
      },
      (error) {
        final message = error.toString();
        if (message == 'guest') {
          emit(AccountGuestState());
          return;
        }
        emit(
          AccountErrorState(
            msg: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
      },
    );
  }

  void _populateEditControllers(AccountDataEntity data) {
    firstNameController.text = data.profile.firstName;
    lastNameController.text = data.profile.lastName;
    emailController.text = data.email;
    phoneController.text = data.profile.phoneNumber ?? '';
  }

  Future<void> saveProfile() async {
    final current = state;
    if (current is! AccountLoadedState) return;

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phone = phoneController.text.trim();
    final fullName = [firstName, lastName]
        .where((part) => part.isNotEmpty)
        .join(' ');

    if (fullName.isEmpty) {
      emit(const AccountErrorState(msg: 'First name is required'));
      emit(current);
      return;
    }

    emit(AccountUpdatingState(data: current.data));

    (await _accountUseCase.updateProfile(
      fullName: fullName,
      phoneNumber: phone.isEmpty ? null : phone,
      avatarUrl: current.data.profile.avatarUrl,
    )).when(
      (profile) {
        final updated = AccountDataEntity(
          profile: profile,
          email: current.data.email,
          pets: current.data.pets,
        );
        _populateEditControllers(updated);
        emit(AccountUpdateSuccessState(data: updated));
        emit(AccountLoadedState(data: updated));
      },
      (error) {
        emit(
          AccountErrorState(
            msg: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
        emit(AccountLoadedState(data: current.data));
      },
    );
  }

  Future<void> logOut() async {
    final previous = state;
    emit(AccountLoading());

    (await _accountUseCase.logOut()).when(
      (_) => emit(AccountLogoutSuccessState()),
      (error) {
        emit(
          AccountErrorState(
            msg: CatchErrorMessage(error: error).getWriteMessage(),
          ),
        );
        if (previous is AccountLoadedState) {
          emit(previous);
        } else if (previous is AccountGuestState) {
          emit(previous);
        }
      },
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
