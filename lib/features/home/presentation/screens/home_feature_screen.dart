import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/presentation/cubit/home_cubit.dart';
import 'package:rifq_v2/features/home/presentation/widgets/add_pet_circle_widget.dart';
import 'package:rifq_v2/features/home/presentation/widgets/home_greeting.dart';
import 'package:rifq_v2/features/home/presentation/widgets/home_header.dart';
import 'package:rifq_v2/features/home/presentation/widgets/pet_circle_widget.dart';
import 'package:rifq_v2/features/home/presentation/widgets/quick_service_widget.dart';
import 'package:rifq_v2/features/home/presentation/widgets/recommendation_carousel_widget.dart';
import 'package:rifq_v2/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:rifq_v2/shared/constants/app_images.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/router/app_router.dart';
import 'package:rifq_v2/shared/presentation/widgets/guest_card_widget.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HomeCubit>()..loadHomeData(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: LottieLoding(),
          );
        }

        if (state is HomeGuestState) {
          return const _HomeBody(isGuest: true);
        }

        if (state is HomeLoadedState) {
          return _HomeBody(isGuest: false, data: state.data);
        }

        if (state is HomeEmptyState) {
          return _HomeBody(isGuest: false, data: state.data);
        }

        if (state is HomeErrorState) {
          return Scaffold(
            backgroundColor: context.background,
            body: Center(
              child: TextButton(
                onPressed: () => context.read<HomeCubit>().loadHomeData(),
                child: const Text('Retry'),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.isGuest, this.data});

  final bool isGuest;
  final HomeDataEntity? data;

  Future<void> _openAccount(BuildContext context) async {
    await context.pushRoute(const AccountRoute());
    if (context.mounted) {
      await context.read<HomeCubit>().loadHomeData(silent: true);
    }
  }

  Future<void> _openPetsList(BuildContext context) async {
    await context.pushRoute(AccountPetsRoute());
    if (context.mounted) {
      await context.read<HomeCubit>().loadHomeData(silent: true);
    }
  }

  Future<void> _openAddPet(BuildContext context) async {
    final result = await context.pushRoute(AddPetRoute());
    if (result == true && context.mounted) {
      await context.read<HomeCubit>().loadHomeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pets = data?.pets ?? const <HomePetEntity>[];

    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              context.read<HomeCubit>().loadHomeData(forceRefresh: true),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  isGuest: isGuest,
                  imageUrl: data?.imageUrl,
                  initials: data?.initials ?? 'U',
                  onAvatarTap: () => _openAccount(context),
                ),
                SizedBox(height: 18.h),
                HomeGreeting(isGuest: isGuest, firstName: data?.firstName),
                if (isGuest) ...[
                  SizedBox(height: 18.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: const GuestCard(),
                  ),
                ],
                if (!isGuest) ...[
                  SizedBox(height: 18.h),
                  _SectionHeader(
                    title: 'Your Pets',
                    actionLabel: 'See all',
                    onAction: () => _openPetsList(context),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 90.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      children: [
                        ...pets.map(
                          (pet) => Padding(
                            padding: EdgeInsets.only(right: 18.w),
                            child: PetCircleWidget(
                              petName: pet.name,
                              imageUrl: pet.photoUrl,
                              onTap: () => _openAccount(context),
                            ),
                          ),
                        ),
                        AddPetCircleWidget(
                          showLabel: pets.isEmpty,
                          onTap: () => _openAddPet(context),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 18.h),
                const _SectionHeader(title: 'Quick Service'),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuickService(
                        assetPath: AppImages.clinicVisit,
                        title: 'Clinic Visit',
                        onTap: () =>
                            context.read<NavCubit>().changeIndex(index: 1),
                      ),
                      QuickService(
                        assetPath: AppImages.petHotel,
                        title: 'Pet Hotel',
                        onTap: () =>
                            context.read<NavCubit>().changeIndex(index: 2),
                      ),
                      QuickService(
                        assetPath: AppImages.adopt,
                        title: 'Adopt',
                        onTap: () =>
                            context.read<NavCubit>().changeIndex(index: 3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                const _SectionHeader(title: 'Recommendations'),
                SizedBox(height: 12.h),
                const RecommendationCarousel(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          Text(
            title,
            style: context.body1.copyWith(color: context.neutral1000),
          ),
          const Spacer(),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: context.body3.copyWith(color: context.neutral600),
              ),
            ),
        ],
      ),
    );
  }
}
