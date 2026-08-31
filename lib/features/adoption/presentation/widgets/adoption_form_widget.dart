import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_text_field/phone_text_field.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_phone_field.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_form_fields.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AdoptionFormScreen extends StatelessWidget {
  const AdoptionFormScreen({super.key, required this.adoptionPostId});

  final String adoptionPostId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AdoptionCubit>(),
      child: _AdoptionFormView(adoptionPostId: adoptionPostId),
    );
  }
}

class _AdoptionFormView extends StatefulWidget {
  const _AdoptionFormView({required this.adoptionPostId});

  final String adoptionPostId;

  @override
  State<_AdoptionFormView> createState() => _AdoptionFormState();
}

class _AdoptionFormState extends State<_AdoptionFormView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _experienceController = TextEditingController();
  final _noteController = TextEditingController();

  PhoneNumber? _phoneNumber;

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _experienceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdoptionCubit, AdoptionState>(
      listenWhen: (previous, current) {
        return previous.isRequestCreated != current.isRequestCreated ||
            previous.errorMessage != current.errorMessage;
      },
      listener: (context, state) {
        // =========================
        // Request created successfully
        // =========================

        if (state.isRequestCreated) {
          _showSuccessDialog(context);
          return;
        }

        // =========================
        // Request error
        // =========================

        if (state.errorMessage != null && !state.isCreatingRequest) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =========================
                    // Title
                    // =========================

                    Center(
                      child: Text(
                        'Adoption Form',
                        style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w600,
                          color: context.primary50,
                        ),
                      ),
                    ),

                    SizedBox(height: 45.h),

                    // =========================
                    // Name
                    // =========================
                    AdoptionFormFields.label(context, 'Name'),

                    SizedBox(height: 7.h),

                    AdoptionFormFields.textField(
                      context: context,
                      controller: _nameController,
                      hintText: '',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 20.h),

                    // =========================
                    // City
                    // =========================
                    AdoptionFormFields.label(context, 'City'),

                    SizedBox(height: 7.h),

                    AdoptionFormFields.textField(
                      context: context,
                      controller: _cityController,
                      hintText: '',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your city';
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 20.h),

                    // =========================
                    // Phone Number
                    // =========================
                    // AdoptionFormFields.label(context, 'Phone Number'),
                    SizedBox(height: 7.h),

                    AccountPhoneField(
                      isRequired: true,
                      borderColor:context.primary50,
                      onChanged: (phone) {
                        _phoneNumber = phone;
                      },
                    ),

                    SizedBox(height: 20.h),

                    // =========================
                    // Experience
                    // =========================
                    AdoptionFormFields.label(context, 'Experience with pets'),

                    SizedBox(height: 7.h),
                    AdoptionFormFields.textField(
                      context: context,
                      controller: _experienceController,
                      hintText: '',
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your experience with pets';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20.h),

                    // =========================
                    // Short Note
                    // =========================
                    AdoptionFormFields.label(context, 'Short note'),

                    SizedBox(height: 7.h),

                    AdoptionFormFields.textField(
                      context: context,
                      controller: _noteController,
                      hintText: '',
                      maxLines: 6,
                      maxLength: 200,
                      counterText: '',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a short note';
                        }
                        return null;
                      },
                    ),

                    // =========================
                    // Character Counter
                    // =========================
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.w, top: 2.h),
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _noteController,
                          builder: (context, value, child) {
                            return Text(
                              '${value.text.length}/200',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: context.neutral300,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 35.h),

                    // =========================
                    // Adopt Button
                    // =========================
                    SizedBox(
                      width: double.infinity,
                      height: 58.h,
                      child: ElevatedButton(
                        onPressed: state.isCreatingRequest ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.primary50,
                          disabledBackgroundColor: context.primary50.withValues(
                            alpha: 0.6,
                          ),
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: state.isCreatingRequest
                            ? SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Adopt',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================
  // Submit
  // =========================

  void _submit() {
    // Prevent duplicate submission
    if (context.read<AdoptionCubit>().state.isCreatingRequest) {
      return;
    }

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get current logged-in user
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please login first')));
      return;
    }

    // Create adoption request
    final request = AdoptionRequestEntity(
      adoptionPostId: widget.adoptionPostId,
      requesterId: userId,
      message: _noteController.text.trim(),
      experience: _experienceController.text.trim(),
    );

    context.read<AdoptionCubit>().createAdoptionRequest(
      adoptionRequest: request,
    );
  }

  // =========================
  // Success Dialog
  // =========================

  void _showSuccessDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =========================
                // Success Icon
                // =========================

                Container(
                  width: 126.r,
                  height: 126.r,
                  decoration: BoxDecoration(
                    color: context.primary50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 78.r,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 28.h),

                // =========================
                // Title
                // =========================
                Text(
                  'Request sent successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: context.primary50,
                  ),
                ),

                SizedBox(height: 12.h),

                // =========================
                // Description
                // =========================
                Text(
                  'Your adoption request has been sent to the owner.\n'
                  'You will be notified once they respond.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: context.neutral500,
                  ),
                ),

                SizedBox(height: 26.h),

                // =========================
                // Back To Home
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();

                      context.router.popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary50,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
