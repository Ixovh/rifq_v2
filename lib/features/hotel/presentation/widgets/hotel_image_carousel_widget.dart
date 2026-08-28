import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_image_placeholder_widget.dart';

class HotelImageCarousel extends StatefulWidget {
  const HotelImageCarousel({
    super.key,
    required this.images,
    required this.onBack,
  });

  final List<HotelImageEntity> images;
  final VoidCallback onBack;

  @override
  State<HotelImageCarousel> createState() => _HotelImageCarouselState();
}

class _HotelImageCarouselState extends State<HotelImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final height = 260.h;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (images.isEmpty)
            const HotelImagePlaceholder(iconSize: 48)
          else
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return Image.network(
                  images[index].imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const HotelImagePlaceholder(iconSize: 48),
                );
              },
              options: CarouselOptions(
                height: height,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    setState(() => _currentIndex = index),
              ),
            ),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: SafeArea(
              bottom: false,
              child: _CircleIconButton(
                icon: Icons.arrow_back_ios_new,
                onTap: widget.onBack,
              ),
            ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: 12.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  final isActive = index == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: isActive ? 18.w : 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Icon(icon, color: Colors.white, size: 18.sp),
        ),
      ),
    );
  }
}
