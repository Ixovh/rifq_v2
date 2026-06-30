import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rifq_v2/core/navigation/app_router.dart';
import 'package:rifq_v2/core/navigation/routers.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';
import 'package:rifq_v2/core/widgets/appbar/custom_app_bar.dart';
import 'package:rifq_v2/core/widgets/guest_card/guest_card_widget.dart';
import 'package:rifq_v2/core/widgets/lottie_loading/lottie_loding.dart';
import 'package:rifq_v2/features/add_pet/data/models/pet_model.dart';
import 'package:rifq_v2/features/home/presentation/cubit/home_cubit.dart';
import 'package:rifq_v2/features/home/presentation/widgets/add_pet_circle_widget.dart';
import 'package:rifq_v2/features/home/presentation/widgets/quick_service_widget.dart';
import 'package:rifq_v2/features/home/presentation/widgets/recommendation_carousel_widget.dart';
import 'package:rifq_v2/features/nav/prsentaion/cubit/nav_cubit.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HomeCubit>()..loadHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return LottieLoding();
          }

          //!!==========guest=============
          if (state is HomeGuestState) {
            return HomeContent(username: "Guest", isGuest: true, pets: []);
          }

          //!!===========signed==============
          if (state is HomeLoadedState) {
            return HomeContent(
              username: state.username,
              isGuest: false,
              pets: state.pets,
            );
          }

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String username;
  final bool isGuest;
  final List<PetModel> pets;

  const HomeContent({
    super.key,
    required this.username,
    required this.isGuest,
    required this.pets,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      backgroundColor: context.neutral100,

      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomeCubit>().loadHomeData();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Hello, ", style: context.h4),
                  Text(
                    username,
                    style: context.h4.copyWith(color: context.primary50),
                  ),
                ],
              ),
              SizedBox(height: 4),

              //!!=========== is guest? show the guest card ==============
              if (isGuest) ...[GuestCard(), SizedBox(height: 20)],

              //!!===========is signed show pets and add button =============
              if (!isGuest) ...[
                Text("Your Pets", style: context.body2),
                SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    children: [
                      ...pets.map((pet) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          // child: PetCircleWidget(
                          //   petName: pet.name,
                          //   imageUrl: pet.photoUrl,
                          //   onTap: () {
                          //     context.push(Routes.healthRecourdpet);
                          //   },
                          // ),
                        );
                      }),
                      SizedBox(width: 10),
                      AddPetCircleWidget(
                        onTap: () async {
                          final result = await context.pushRoute(AddPetRoute());

                          if (result == true) {
                            //!!---load pets---
                            if (context.mounted) {
                              context.read<HomeCubit>().loadHomeData();
                            }
                          }
                        },
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
              //!!--------quick services----------
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Quick Service", style: context.body1),
                  Spacer(),
                  Text(
                    "See More..",
                    style: context.body3.copyWith(color: context.neutral600),
                  ),
                ],
              ),
              SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuickService(
                      imagePath: 'assets/images/clinic.png',
                      title: 'Clinic Visit',
                      onTap: () {
                        context.read<NavCubit>().changeIndex(index: 1);
                      },
                    ),
                    SizedBox(width: 10),
                    QuickService(
                      imagePath: 'assets/images/Frame 1984077916.png',
                      title: 'Pet Hotel',
                      onTap: () {
                        context.read<NavCubit>().changeIndex(index: 2);
                      },
                    ),
                    SizedBox(width: 10),
                    QuickService(
                      imagePath: 'assets/images/Frame 1984077917.png',
                      title: 'Adopt',
                      onTap: () {
                        context.read<NavCubit>().changeIndex(index: 3);
                      },
                    ),
                    SizedBox(width: 12),
                    // QuickService(
                    //   imagePath: 'assets/images/store.png',
                    //   title: 'Pet Store',
                    //   onTap: () {
                    //     context.push(Routes.store);
                    //     context.read<NavCubit>().changeIndex(index: 3);
                    //   },
                    // ),
                  ],
                ),
              ),

              //!!--------recommendations----------
              SizedBox(height: 30),
              Text("Exclusive Deals", style: context.body1),
              SizedBox(height: 12),
              RecommendationCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}