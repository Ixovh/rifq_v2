import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/presentation/widgets/hotel_image_placeholder_widget.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class HotelImageCarousel extends StatefulWidget {
  const HotelImageCarousel({
    super.key,
    required this.images,
    required this.onBack,
    this.title,
  });

  final List<HotelImageEntity> images;
  final VoidCallback onBack;
  final String? title;

  @override
  State<HotelImageCarousel> createState() => _HotelImageCarouselState();
}

class _HotelImageCarouselState extends State<HotelImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final height = 338.h;
    final bottomRadius = Radius.circular(30.r);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: bottomRadius,
        bottomRight: bottomRadius,
      ),
      child: SizedBox(
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
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(18.w, 8.h, 18.w, 0),
                  child: Row(
                    children: [
                      _CircleIconButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: widget.onBack,
                      ),
                      Expanded(
                        child: Text(
                          widget.title ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.body1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            shadows: const [
                              Shadow(color: Colors.black45, blurRadius: 8),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 33.w),
                    ],
                  ),
                ),
              ),
            ),
            if (images.length > 1)
              Positioned(
                bottom: 18.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    final isActive = index == _currentIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: isActive ? 10.w : 8.w,
                      height: isActive ? 10.w : 8.w,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF3AB7A5)
                            : Colors.white.withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                        border: isActive
                            ? null
                            : Border.all(color: Colors.white, width: 1),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
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
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Icon(icon, color: Colors.white, size: 20.sp),
        ),
      ),
    );
  }
}
