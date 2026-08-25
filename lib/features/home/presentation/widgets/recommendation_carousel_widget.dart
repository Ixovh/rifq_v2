import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/shared/constants/app_images.dart';
import 'package:rifq_v2/features/home/presentation/widgets/recommendation_card_widget.dart';

class RecommendationCarousel extends StatelessWidget {
  const RecommendationCarousel({super.key});

  static const _adsImages = [
    AppImages.recommendationClinic,
    AppImages.recommendationTips,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.92),
        itemCount: _adsImages.length,
        itemBuilder: (context, index) {
          return RecommendationCard(imagePath: _adsImages[index]);
        },
      ),
    );
  }
}
