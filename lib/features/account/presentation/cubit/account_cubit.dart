import 'dart:io';

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

  Future<void> loadAccount({bool forceRefresh = false}) async {
    emit(AccountLoading());

    if (AuthHelper.isGuestUser()) {
      emit(AccountGuestState());
      return;
    }

    (await _accountUseCase.getAccountData(forceRefresh: forceRefresh)).when(
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

  Future<void> saveProfile({
    File? imageFile,
    bool removeImage = false,
    // Localized validation copy, passed from the screen so the cubit stays
    // free of a BuildContext.
    required String firstNameRequiredMessage,
    required String emailRequiredMessage,
    required String invalidEmailMessage,
  }) async {
    final current = state;
    if (current is! AccountLoadedState) return;

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final fullName = [
      firstName,
      lastName,
    ].where((part) => part.isNotEmpty).join(' ');

    if (fullName.isEmpty) {
      emit(AccountErrorState(msg: firstNameRequiredMessage));
      emit(current);
      return;
    }

    if (email.isEmpty) {
      emit(AccountErrorState(msg: emailRequiredMessage));
      emit(current);
      return;
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      emit(AccountErrorState(msg: invalidEmailMessage));
      emit(current);
      return;
    }

    emit(AccountUpdatingState(data: current.data));

    (await _accountUseCase.updateProfile(
      fullName: fullName,
      phoneNumber: phone.isEmpty ? null : phone,
      imageFile: imageFile,
      removeImage: removeImage,
      email: email,
    )).when(
      (result) {
        final updated = AccountDataEntity(
          profile: result.profile,
          email: result.email,
          pets: current.data.pets,
        );
        _populateEditControllers(updated);
        emit(
          AccountUpdateSuccessState(
            data: updated,
            emailConfirmationPending: result.emailConfirmationPending,
            pendingEmail: result.pendingEmail,
          ),
        );
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
