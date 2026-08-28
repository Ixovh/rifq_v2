import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_header_widget.dart';
import 'package:rifq_v2/features/adoption/presentation/widgets/adoption_tabs_widgets.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/service_locator/service_locator.dart';

import '../cubit/adoption_cubit.dart';

import '../widgets/pet_categories_section.dart';
@RoutePage()

class AdoptionFeatureScreen extends StatelessWidget {
  const AdoptionFeatureScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (_) => getIt<AdoptionCubit>(),
      child: const _AdoptionView(),
    );
  }
}

class _AdoptionView extends StatelessWidget {
  const _AdoptionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton.extended(
          onPressed: () {
            // بعدين هنا نفتح صفحة إضافة حيوان للتبني
          },
          backgroundColor: context.primary50,
          elevation: 2,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Adopt',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Column(
          children: [
            AdoptionHeader(
              onNotificationTap: () {
                // TODO
              },
            ),

            const SizedBox(height: 12),

            PetCategoriesSection(
              onMoreCategoryTap: () {},
            ),

            const SizedBox(height: 12),

            const AdoptionTabs(),

            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

// class _AdoptionView extends StatelessWidget {
//   const _AdoptionView();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             AdoptionHeader(
//               onNotificationTap: () {
//                 // TODO: Notifications
//               },
//             ),

//             const SizedBox(height: 12),

//             PetCategoriesSection(
//               onMoreCategoryTap: () {
//                 // TODO: More categories
//               },
//             ),

//             const SizedBox(height: 12),

//             const AdoptionTabs(),

//             // المحتوى حق كل تاب بنضيفه هنا بعدين
//             const Expanded(
//               child: SizedBox(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }