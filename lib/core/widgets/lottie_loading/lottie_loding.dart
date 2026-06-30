import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoding extends StatelessWidget {
  const LottieLoding({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/Lovely cats.json',
        width: 190,
        height: 190,
        fit: BoxFit.contain,
      ),
    );
  }
}
