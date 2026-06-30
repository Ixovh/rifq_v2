import 'package:flutter/material.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';

class QuickService extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const QuickService({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 113,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:  0.14),
              blurRadius: 10,
              offset:  Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 85,
            ),
            Text(
              title,
              style:  context.body3,
            ),
          ],
        ),
      ),
    );
  }
}