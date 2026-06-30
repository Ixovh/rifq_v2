import 'package:flutter/material.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';

class RecommendationCard extends StatelessWidget {
  final String imagePath;

  const RecommendationCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: context.red10,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(imagePath, fit: BoxFit.fill),
      ),
    );
  }
}