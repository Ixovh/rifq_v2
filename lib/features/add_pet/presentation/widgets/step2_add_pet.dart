import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';


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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // ----------------age----------------
            Text("What's your pet's age ?", style: context.body1),
            SizedBox(height: 10),

            InkWell(
              onTap: () async {
                final today = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedBirthdate ?? today,
                  firstDate: DateTime(2000),
                  lastDate: today,
                );

                if (picked != null) {
                  onBirthdateSelected(picked);
                }
              },
              child: Container(
                height: 58,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.calendar, color: Colors.grey.shade600),
                    SizedBox(width: 10),
                    Text(
                      selectedBirthdate == null
                          ? "Choose Date"
                          : DateFormat('dd/MM/yyyy').format(selectedBirthdate!),
                      style: TextStyle(
                        color: selectedBirthdate == null
                            ? Colors.grey.shade500
                            : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (selectedBirthdate != null) ...[
               SizedBox(height: 8),
              Text(
                "Age: ${_calculateAge(selectedBirthdate!)} years",
                style: context.body2.copyWith(color: context.neutral600),
              ),
            ],

            SizedBox(height: 30),

            // ----------------species----------------
            Text("What type of pet do you have ?", style: context.body1),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSpeciesBox(
                  context,
                  img: "assets/images/Frame 1984077842.png",
                  label: "Cat",
                  selected: selectedSpecies == "cat",
                  onTap: () => onSpeciesSelected("cat"),
                ),
                _buildSpeciesBox(
                  context,
                  img: "assets/images/Frame 1984077843.png",
                  label: "Dog",
                  selected: selectedSpecies == "dog",
                  onTap: () => onSpeciesSelected("dog"),
                ),
              ],
            ),

            SizedBox(height: 20),

            _buildOtherOption(context),
            SizedBox(height: 30),

            // ----------------BREED----------------
            Text("What's your pet's breed ?", style: context.body1),
            SizedBox(height: 20),

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
                  hintText: "Husky",
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
                color: selected ? Color(0xff2DB598) : Colors.transparent,
                width: 3,
              ),
              image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: context.body1.copyWith(
              color: selected ? Color(0xff2DB598) : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  int _calculateAge(DateTime birthdate) {
    final now = DateTime.now();
    int years = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      years--;
    }
    return years;
  }

  Widget _buildOtherOption(BuildContext context) {
    final isSelected = selectedSpecies == "other";

    return InkWell(
      onTap: () => onSpeciesSelected("other"),
      child: Container(
        height: 58,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffE4F7F1) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xff2DB598) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Other", style: context.body1),
            Icon(CupertinoIcons.chevron_down, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
