import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/edit_pet/presentation/cubit/edit_pet_cubit.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_confirm_sheet.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';

final _deletingPetIds = <String>{};

/// Confirms, deletes the owned pet, and reports whether the row was removed.
Future<bool> confirmAndDeletePet({
  required BuildContext context,
  required String petId,
  required String petName,
  EditPetCubit? cubit,
}) async {
  if (_deletingPetIds.contains(petId)) return false;

  final l10n = AppLocalizations.of(context)!;
  final confirmed = await showAppConfirmSheet(
    context: context,
    title: l10n.editPet_deleteTitle,
    message: l10n.editPet_deleteMessage(petName),
    confirmLabel: l10n.editPet_delete,
    icon: Icons.delete_outline_rounded,
    isDestructive: true,
  );
  if (!confirmed || !context.mounted) return false;

  final ownsCubit = cubit == null;
  final deleteCubit = cubit ?? GetIt.I<EditPetCubit>();
  _deletingPetIds.add(petId);
  try {
    final error = await deleteCubit.deletePet(petId);
    if (!context.mounted) return error == null;
    if (error != null) {
      context.showErrorToast(error);
      return false;
    }
    return true;
  } finally {
    _deletingPetIds.remove(petId);
    if (ownsCubit) await deleteCubit.close();
  }
}

void showPetDeletedToast(BuildContext context) {
  context.showSuccessToast(AppLocalizations.of(context)!.editPet_deleted);
}
