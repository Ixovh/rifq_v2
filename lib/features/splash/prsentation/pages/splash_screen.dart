import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Duration minDuration = 2000.ms;

  @override
  void initState() {
    super.initState();
      debugPrint("Splash init");
    Future.delayed(minDuration, _checkAuth);
  }



  Future<void> _checkAuth() async {
  final session = Supabase.instance.client.auth.currentUser;
  PageRouteInfo route = const ChoosePathRoute();


    if (session != null) {
    // ✅ هذا هو الإصلاح - تحقق أولاً
    if (session.emailConfirmedAt == null) {
      await Supabase.instance.client.auth.signOut();
      if (!mounted) return;
      context.router.replace(const ChoosePathRoute());
      return;
    }

    final profile = await Supabase.instance.client
        .from('profiles')
        .select('id, role')
        .eq('id', session.id)
        .maybeSingle();

    if (profile != null) {
      final role = profile['role'] as String?;
      if (role == 'pet_owner') {
        route = const NavWrapperRoute();
      } else if (role == 'service_provider') {
        route = const NavWrapperRoute(); // غيّره لاحقاً لشاشة مقدم الخدمة
      }
    }
  }

  if (!mounted) return;
  context.router.replace(route);
}
//حق حاتم القديم
//   Future<void> _checkAuth() async {
//     final session = Supabase.instance.client.auth.currentUser;
//     PageRouteInfo route = const ChoosePathRoute();

//     if (session != null) {
//       final provider = await Supabase.instance.client
//           .from('profiles')
//           .select('id')
//           .eq('id', session.id)
//           .maybeSingle();

//       final user = await Supabase.instance.client
//           .from('users')
//           .select('id')
//           .eq('id', session.id)
//           .maybeSingle();

//       // if (user != null) {
//       //   route = Routes.navbar;
//       // } else if (provider != null) {
//       //   route = Routes.providerNavbar;
//       // }
//     }
//     if (!mounted) return;
// context.router.replace(route); 
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primary,
      body: Stack(
        children: [
          Container(color: Colors.white),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                      'assets/splash/rifq.svg',
                      width: 145.w,
                      height: 85.h,
                    )
                    .animate()
                    .fadeIn(
                      delay: 1100.ms,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    )
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      delay: 1100.ms,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),
                SizedBox(width: 16.h),

                SvgPicture.asset(
                      'assets/splash/logo.svg',
                      width: 64.w,
                      height: 69.h,
                    )
                    .animate()
                    .fadeIn(
                      delay: 1100.ms,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    )
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      delay: 1100.ms,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),
              ],
            ),
          ),

          Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Container(
                        width: 1.sw / 2 + 20.w,
                        height: 1.sh,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              context.primary.withValues(alpha: 0.6),
                              context.primary,
                              context.primary400,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.primary.withValues(alpha: 0.6),
                              blurRadius: 40.r,
                              spreadRadius: 15.r,
                              offset: Offset(5.w, 0),
                            ),
                          ],
                        ),
                      ).animate().custom(
                        delay: 500.ms,
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                        begin: 0.0,
                        end: 1.0,
                        builder: (context, value, child) {
                          final slideOffset = -value * (1.sw / 2 + 20.w);
                          final taperOffset = value * 50.w;
                          return ClipPath(
                            clipper: _TrapezoidalClipper(
                              leftOffset: 0,
                              rightOffset: taperOffset,
                            ),
                            child: Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.003)
                                ..rotateY(-0.8 * value),
                              child: Transform.translate(
                                offset: Offset(slideOffset, 0),
                                child: child,
                              ),
                            ),
                          );
                        },
                      ),
                ),
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child:
                      Container(
                        width: 1.sw / 2 + 20.w,
                        height: 1.sh,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              context.primary.withValues(alpha: 0.6),
                              context.primary,
                              context.primary400,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.primary.withValues(alpha: 0.6),
                              blurRadius: 40.r,
                              spreadRadius: 15.r,
                              offset: Offset(-5.w, 0),
                            ),
                          ],
                        ),
                      ).animate().custom(
                        delay: 500.ms,
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                        begin: 0.0,
                        end: 1.0,
                        builder: (context, value, child) {
                          final slideOffset = value * (1.sw / 2 + 20.w);
                          final taperOffset = value * 50.w;

                          return ClipPath(
                            clipper: _TrapezoidalClipper(
                              leftOffset: taperOffset,
                              rightOffset: 0,
                            ),
                            child: Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.003)
                                ..rotateY(0.8 * value),
                              child: Transform.translate(
                                offset: Offset(slideOffset, 0),
                                child: child,
                              ),
                            ),
                          );
                        },
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/// Custom clipper for trapezoidal door shape
class _TrapezoidalClipper extends CustomClipper<Path> {
  final double leftOffset;
  final double rightOffset;

  _TrapezoidalClipper({required this.leftOffset, required this.rightOffset});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(leftOffset, 0);
    path.lineTo(size.width - rightOffset, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TrapezoidalClipper oldClipper) {
    return oldClipper.leftOffset != leftOffset ||
        oldClipper.rightOffset != rightOffset;
  }
}