import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AddPetStepTwo extends StatelessWidget {
  final Function(String) onSpeciesSelected;
  final Function(DateTime) onBirthdateSelected;
  final TextEditingController breedCtrl;

  final String selectedSpecies;
  final DateTime? selectedBirthdate;

  const AddPetStepTwo({
    super.key,
    required this.breedCtrl,
    required this.onSpeciesSelected,
    required this.onBirthdateSelected,
    required this.selectedSpecies,
    required this.selectedBirthdate,
  });

  bool get _isDropdownSpecies {
    return selectedSpecies.isNotEmpty &&
        selectedSpecies != 'cat' &&
        selectedSpecies != 'dog';
  }

  String get _dropdownLabel {
    for (final option in otherSpecies) {
      if (option.value == selectedSpecies) return option.label;
    }
    return 'Other';
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showAppDatePicker(
      context: context,
      selectedDate: selectedBirthdate,
      title: 'Choose date of birth',
    );
    if (picked != null) onBirthdateSelected(picked);
  }

  Future<void> _pickSpecies(BuildContext context) async {
    final picked = await showAppSpeciesSheet(
      context: context,
      selectedSpecies: selectedSpecies,
    );
    if (picked != null) onSpeciesSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("What's your pet's age ?", style: context.body1),
            const SizedBox(height: 10),
            _InputTile(
              onTap: () => _pickDate(context),
              isActive: selectedBirthdate != null,
              leading: Icon(
                CupertinoIcons.calendar,
                color: selectedBirthdate != null
                    ? context.primary300
                    : context.neutral600,
              ),
              label: selectedBirthdate == null
                  ? 'Choose Date'
                  : DateFormat('dd/MM/yyyy').format(selectedBirthdate!),
              isPlaceholder: selectedBirthdate == null,
            ),
            if (selectedBirthdate != null) ...[
              const SizedBox(height: 8),
              Text(
                'Age: ${_ageLabel(selectedBirthdate!)}',
                style: context.body2.copyWith(color: context.neutral600),
              ),
            ],
            const SizedBox(height: 30),
            Text('What type of pet do you have ?', style: context.body1),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSpeciesBox(
                  context,
                  img: 'assets/images/Frame 1984077842.png',
                  label: 'Cat',
                  selected: selectedSpecies == 'cat',
                  onTap: () => onSpeciesSelected('cat'),
                ),
                _buildSpeciesBox(
                  context,
                  img: 'assets/images/Frame 1984077843.png',
                  label: 'Dog',
                  selected: selectedSpecies == 'dog',
                  onTap: () => onSpeciesSelected('dog'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _InputTile(
              onTap: () => _pickSpecies(context),
              isActive: _isDropdownSpecies,
              label: _dropdownLabel,
              trailing: Icon(
                CupertinoIcons.chevron_down,
                color: _isDropdownSpecies
                    ? context.primary300
                    : context.neutral600,
              ),
            ),
            const SizedBox(height: 30),
            Text("What's your pet's breed ?", style: context.body1),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: TextField(
                controller: breedCtrl,
                style: context.body2,
                decoration: InputDecoration(
                  hintText: 'Husky',
                  hintStyle: context.body2.copyWith(color: context.neutral500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeciesBox(
    BuildContext context, {
    required String img,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? context.primary300 : Colors.transparent,
                width: 3,
              ),
              image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: context.body1.copyWith(
              color: selected ? context.primary300 : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  /// Matches pet profile age formatting (months when under 1 year).
  String _ageLabel(DateTime birthdate) {
    final now = DateTime.now();
    var months =
        (now.year - birthdate.year) * 12 + now.month - birthdate.month;
    if (now.day < birthdate.day) months--;
    if (months < 0) months = 0;

    if (months < 12) {
      final display = months < 1 ? 1 : months;
      return display == 1 ? '1 month' : '$display month';
    }

    final years = months ~/ 12;
    return years == 1 ? '1 Year' : '$years Years';
  }
}

class _InputTile extends StatelessWidget {
  const _InputTile({
    required this.onTap,
    required this.label,
    required this.isActive,
    this.leading,
    this.trailing,
    this.isPlaceholder = false,
  });

  final VoidCallback onTap;
  final String label;
  final bool isActive;
  final Widget? leading;
  final Widget? trailing;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? const Color(0xffE4F7F1) : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 58,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive ? context.primary300 : Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              ?leading,
              if (leading != null) const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: context.body2.copyWith(
                    color: isPlaceholder
                        ? context.neutral500
                        : context.neutral1000,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
