import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';

class AdoptionFeatureScreen extends StatelessWidget {
  const AdoptionFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _ = context.read<AdoptionCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.adoption_screenTitle),
      ),
      body: Column(children: []),
    );
  }
}
