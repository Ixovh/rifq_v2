import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_text_field/phone_text_field.dart';
import 'package:rifq_v2/features/account/presentation/widgets/account_phone_field.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

@RoutePage()
class AdoptionFormScreen extends StatefulWidget {
  const AdoptionFormScreen({super.key});

  @override
  State<AdoptionFormScreen> createState() => _AdoptionFormState();
}

class _AdoptionFormState extends State<AdoptionFormScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,

      // =========================
      // App Bar
      // =========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      // =========================
      // Body
      // =========================
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
                _buildLabel(context, 'Name'),

                SizedBox(height: 7.h),

                _buildTextField(
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
                _buildLabel(context, 'City'),

                SizedBox(height: 7.h),

                _buildTextField(
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
                // AccountPhoneField(
                //   isRequired: true,
                //   onChanged: (phone) {
                //     _phoneNumber = phone;
                //   },
                // ),

                SizedBox(height: 7.h),

                AccountPhoneField(
                  isRequired: true,
                  onChanged: (phone) {
                    _phoneNumber = phone;
                  },
                ),

                SizedBox(height: 20.h),

                // =========================
                // Experience
                // =========================
                _buildLabel(context, 'Experience with pets', optional: true),

                SizedBox(height: 7.h),

                _buildTextField(
                  controller: _experienceController,
                  hintText: '',
                  maxLines: 1,
                ),

                SizedBox(height: 20.h),

                // =========================
                // Short Note
                // =========================
                _buildLabel(context, 'Short note', optional: true),

                SizedBox(height: 7.h),

                _buildTextField(
                  controller: _noteController,
                  hintText: '',
                  maxLines: 6,
                  maxLength: 200,
                  counterText: '',
                ),

                // =========================
                // Character Counter
                // =========================
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w, top: 2.h),
                    child: ValueListenableBuilder(
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
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary50,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
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
  }

  // =========================
  // Label
  // =========================

  Widget _buildLabel(
    BuildContext context,
    String title, {
    bool optional = false,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: context.neutral700,
            ),
          ),

          if (optional)
            TextSpan(
              text: '  (Optional)',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: context.neutral400,
              ),
            ),
        ],
      ),
    );
  }

  // =========================
  // Text Field
  // =========================

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    int? maxLength,
    String? counterText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      style: TextStyle(fontSize: 16.sp, color: context.neutral700),
      decoration: InputDecoration(
        hintText: hintText,
        counterText: counterText,

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(
            color: context.primary.withValues(alpha: 0.7),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: context.primary, width: 1.2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  // =========================
  // Submit
  // =========================

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    debugPrint('========== ADOPTION FORM ==========');

    debugPrint('Name: ${_nameController.text}');

    debugPrint('City: ${_cityController.text}');

    debugPrint('Country: ${_phoneNumber?.countryISOCode}');

    debugPrint('Country Code: ${_phoneNumber?.countryCode}');

    debugPrint('Phone: ${_phoneNumber?.number}');

    debugPrint('Complete Phone: ${_phoneNumber?.completeNumber}');

    debugPrint('Experience: ${_experienceController.text}');

    debugPrint('Note: ${_noteController.text}');

    debugPrint('===================================');
  }
}
