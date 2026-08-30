import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AddPetStepOne extends StatelessWidget {
  final TextEditingController nameCtrl;
  final Function(String) onGenderSelected;
  final Function(File) onImagePicked;
  final File? photoFile;
  final String selectedGender;

  const AddPetStepOne({
    super.key,
    required this.onGenderSelected,
    required this.nameCtrl,
    required this.onImagePicked,
    required this.photoFile,
    required this.selectedGender,
  });

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      onImagePicked(File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: context.background,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),

            ///-------------input photo-------------------------
            Center(
              child: Text(l10n.addPet_uploadPhoto, style: context.body1),
            ),
            SizedBox(height: 24),

            Center(
              child: GestureDetector(
                onTap: () => pickImage(context),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.30),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: photoFile == null
                            ? Icon(
                                CupertinoIcons.camera,
                                size: 75,
                                color: context.neutral600,
                              )
                            : ClipOval(
                                child: Image.file(
                                  photoFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    //--------------------------add icon-------------------------
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.primary50,
                          boxShadow: [
                            BoxShadow(
                              color: context.primary50.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///-------------input photo-------------------------
            SizedBox(height: 40),

            ///-------------input name-------------------------
            Text(l10n.addPet_nameQuestion, style: context.body1),
            SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: TextField(
                controller: nameCtrl,
                style: context.body2,
                decoration: InputDecoration(
                  hintText: l10n.addPet_nameHint,
                  hintStyle: context.body2.copyWith(color: context.neutral500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Icon(
                      Icons.pets,
                      color: context.neutral500,
                      size: 25,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 50,
                    minHeight: 50,
                  ),
                ),
              ),
            ),

            ///-------------input name-------------------------
            SizedBox(height: 32),

            ///-------------input gender-------------------------
            Text(l10n.addPet_genderQuestion, style: context.body1),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _GenderOption(
                    title: l10n.common_genderMale,
                    icon: Icons.male,
                    isSelected: selectedGender.toLowerCase() == "male",
                    onTap: () => onGenderSelected("male"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _GenderOption(
                    title: l10n.common_genderFemale,
                    icon: Icons.female,
                    isSelected: selectedGender.toLowerCase() == "female",
                    onTap: () => onGenderSelected("female"),
                  ),
                ),
              ],
            ),

            ///-------------input gender-------------------------
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF2CC9A6);
    final Color borderColor = isSelected
        ? activeColor
        : const Color(0xFFE5E5E5);
    final Color bgColor = isSelected ? const Color(0xFFE8F8F4) : Colors.white;
    final Color iconColor = isSelected ? activeColor : Colors.black87;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 25),
            SizedBox(width: 8),
            Text(title, style: context.body2.copyWith(color: iconColor)),
          ],
        ),
      ),
    );
  }
}
