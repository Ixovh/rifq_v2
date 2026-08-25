import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rifq_v2/features/health_record/domain/entities/health_record_entity.dart';
import 'package:rifq_v2/features/health_record/presentation/cubit/health_record_cubit.dart';
import 'package:rifq_v2/features/health_record/presentation/widgets/add_health_record_sheet.dart';
import 'package:rifq_v2/shared/constants/app_images.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/lottie_loding.dart';

class PetHealthRecordTab extends StatelessWidget {
  const PetHealthRecordTab({super.key, required this.petId});

  final String petId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthRecordCubit, HealthRecordState>(
      builder: (context, state) {
        if (state is HealthRecordLoading || state is HealthRecordInitial) {
          return const Center(child: LottieLoding());
        }

        final records = switch (state) {
          HealthRecordLoaded(:final records) => records,
          HealthRecordSaving(:final records) => records,
          HealthRecordError(:final records) => records,
          _ => const <HealthRecordEntity>[],
        };

        final isEmpty = records.isEmpty;

        return Stack(
          children: [
            if (isEmpty)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Image.asset(
                    AppImages.healthRecordEmpty,
                    width: 180.w,
                    height: 157.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            if (isEmpty)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 200.h),
                  child: Text(
                    'No Health Record Yet',
                    style: context.body1.copyWith(
                      color: context.neutral700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            if (!isEmpty)
              ListView.separated(
                padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 100.h),
                itemCount: records.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return _HealthRecordCard(record: records[index]);
                },
              ),
            Positioned(
              left: 18.w,
              right: 18.w,
              bottom: 16.h,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(250.r),
                color: context.primary300,
                child: InkWell(
                  onTap: () =>
                      showAddHealthRecordSheet(context: context, petId: petId),
                  borderRadius: BorderRadius.circular(250.r),
                  child: Container(
                    height: 58.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Add new health record',
                      style: context.bodyLarge.copyWith(
                        color: context.neutral100,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HealthRecordCard extends StatelessWidget {
  const _HealthRecordCard({required this.record});

  final HealthRecordEntity record;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.neutral100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            record.title,
            style: context.body1.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h),
          Text(
            record.recordType,
            style: context.body3.copyWith(color: context.primary300),
          ),
          if (record.clinicName?.isNotEmpty ?? false) ...[
            SizedBox(height: 6.h),
            Text(
              record.clinicName!,
              style: context.body3.copyWith(color: context.neutral600),
            ),
          ],
          SizedBox(height: 6.h),
          Text(
            DateFormat('dd MMM yyyy').format(record.visitDate),
            style: context.body3.copyWith(color: context.neutral500),
          ),
          if (record.description?.isNotEmpty ?? false) ...[
            SizedBox(height: 8.h),
            Text(
              record.description!,
              style: context.body3.copyWith(color: context.neutral700),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
