import 'package:flutter/material.dart';

class AddPetStepper extends StatelessWidget {
  final int currentStep;

  const AddPetStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLine(
          isActive: currentStep == 0 || currentStep == 1,
          width: 120,
        ),
        const SizedBox(width: 10),
        _buildLine(
          isActive: currentStep == 1,
          width: 120,
        ),
      ],
    );
  }

  Widget _buildLine({required bool isActive, required double width}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 2,
      width: width,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xff2DB598) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
