import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rifq_v2/features/home/presentation/widgets/recommendation_card_widget.dart';

class RecommendationCarousel extends StatelessWidget {
  const RecommendationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final adsImages = [
      'assets/images/ad1.png',
      'assets/images/ad2.png',
      'assets/images/ad3.png',
    ];

    return CarouselSlider(
      items: adsImages.map((image) {
        return RecommendationCard(imagePath: image);
      }).toList(),

      options: CarouselOptions(
        height: 155,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        viewportFraction: 0.75,
      ),
    );
  }
}