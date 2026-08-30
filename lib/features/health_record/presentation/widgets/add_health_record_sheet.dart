import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';
import 'package:rifq_v2/features/health_record/presentation/cubit/health_record_cubit.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_toast.dart';
import 'package:rifq_v2/shared/presentation/widgets/container_button.dart';

Future<void> showAddHealthRecordSheet({
  required BuildContext context,
  required String petId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return BlocProvider.value(
        value: context.read<HealthRecordCubit>(),
        child: _AddHealthRecordSheet(petId: petId),
      );
    },
  );
}

class _AddHealthRecordSheet extends StatefulWidget {
  const _AddHealthRecordSheet({required this.petId});

  final String petId;

  @override
  State<_AddHealthRecordSheet> createState() => _AddHealthRecordSheetState();
}

class _AddHealthRecordSheetState extends State<_AddHealthRecordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _typeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _clinicController = TextEditingController();
  DateTime? _visitDate;
  var _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    _clinicController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showAppDatePicker(
      context: context,
      selectedDate: _visitDate,
      title: AppLocalizations.of(context)!.healthRecord_chooseVisitDate,
    );
    if (picked != null) setState(() => _visitDate = picked);
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_visitDate == null) {
      context.showWarningToast(
        AppLocalizations.of(context)!.healthRecord_visitDateRequired,
      );
      return;
    }

    setState(() => _isSaving = true);

    final success = await context.read<HealthRecordCubit>().addRecord(
      petId: widget.petId,
      title: _titleController.text,
      recordType: _typeController.text,
      description: _descriptionController.text,
      clinicName: _clinicController.text,
      visitDate: _visitDate!,
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      context.showSuccessToast(
        AppLocalizations.of(context)!.healthRecord_saved,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        AppLocalizations.of(context)!.healthRecord_addTitle,
                        style: context.h4.copyWith(
                          color: context.primary300,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          size: 22.sp,
                          color: context.neutral600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  _HealthRecordField(
                    label: AppLocalizations.of(
                      context,
                    )!.healthRecord_fieldTitle,
                    icon: Icons.badge_outlined,
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.healthRecord_titleRequired;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  _HealthRecordField(
                    label: AppLocalizations.of(context)!.healthRecord_fieldType,
                    icon: Icons.pets_outlined,
                    controller: _typeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.healthRecord_typeRequired;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  _HealthRecordField(
                    label: AppLocalizations.of(
                      context,
                    )!.healthRecord_fieldDescription,
                    icon: Icons.menu_book_outlined,
                    controller: _descriptionController,
                    maxLines: 4,
                    minHeight: 120,
                  ),
                  SizedBox(height: 24.h),
                  _HealthRecordField(
                    label: AppLocalizations.of(
                      context,
                    )!.healthRecord_fieldClinic,
                    icon: Icons.local_hospital_outlined,
                    controller: _clinicController,
                  ),
                  SizedBox(height: 24.h),
                  _VisitDateField(visitDate: _visitDate, onTap: _pickDate),
                  SizedBox(height: 28.h),
                  ContainerButton(
                    label: AppLocalizations.of(
                      context,
                    )!.healthRecord_saveRecord,
                    containerColor: context.primary300,
                    textColor: context.neutral100,
                    fontSize: 20,
                    isLoading: _isSaving,
                    onTap: _save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HealthRecordField extends StatelessWidget {
  const _HealthRecordField({
    required this.label,
    required this.icon,
    required this.controller,
    this.validator,
    this.maxLines = 1,
    this.minHeight = 56,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: minHeight.h),
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
          decoration: BoxDecoration(
            color: context.neutral100,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: context.neutral200),
          ),
          child: Row(
            crossAxisAlignment: maxLines > 1
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 22.sp, color: context.neutral600),
              SizedBox(width: 12.w),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  maxLines: maxLines,
                  validator: validator,
                  style: context.body2.copyWith(
                    color: context.neutral1000,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        PositionedDirectional(
          start: 22.w,
          top: -10.h,
          child: Container(
            color: context.neutral100,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              label,
              style: context.body3.copyWith(
                color: context.neutral700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VisitDateField extends StatelessWidget {
  const _VisitDateField({required this.visitDate, required this.onTap});

  final DateTime? visitDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasDate = visitDate != null;
    final label = hasDate
        ? DateFormat('dd-MM-yyyy').format(visitDate!)
        : AppLocalizations.of(context)!.common_chooseDate;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: context.neutral100,
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              height: 56.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: context.neutral200),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: hasDate ? context.primary300 : context.neutral600,
                    size: 22.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    label,
                    style: context.body2.copyWith(
                      color: hasDate ? context.neutral1000 : context.neutral500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          start: 22.w,
          top: -10.h,
          child: Container(
            color: context.neutral100,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              AppLocalizations.of(context)!.healthRecord_dateOfVisit,
              style: context.body3.copyWith(
                color: context.neutral700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
