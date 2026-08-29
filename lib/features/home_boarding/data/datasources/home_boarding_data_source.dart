import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home_boarding/data/models/boarding_request_model.dart';
import 'package:rifq_v2/features/home_boarding/data/models/home_boarding_detail_model.dart';
import 'package:rifq_v2/features/home_boarding/data/models/home_boarding_list_item_model.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/boarding_request_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseHomeBoardingDataSource {
  Future<Result<List<HomeBoardingListItemEntity>, Object>> getSitters({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  });

  Future<Result<HomeBoardingDetailEntity, Object>> getSitterDetail({
    required String sitterId,
  });

  Future<Result<BoardingRequestEntity?, Object>> getPendingRequest({
    required String sitterId,
  });

  Future<Result<BoardingRequestEntity, Object>> sendBoardingRequest({
    required String sitterId,
  });
}

@LazySingleton(as: BaseHomeBoardingDataSource)
class HomeBoardingDataSource implements BaseHomeBoardingDataSource {
  const HomeBoardingDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  static const _sitterListSelect =
      'id, specialty, rating, review_count, area_text, price_per_night, '
      'years_experience, profiles(full_name, image_url, phone_number)';

  static const _sitterDetailSelect =
      'id, specialty, rating, review_count, area_text, price_per_night, '
      'years_experience, bio, profiles(full_name, image_url, phone_number), '
      'home_boarding_skills(id, skill_label)';

  @override
  Future<Result<List<HomeBoardingListItemEntity>, Object>> getSitters({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  }) async {
    try {
      final rows = await _supabase
          .from('home_boarding_profiles')
          .select(_sitterListSelect)
          .eq('is_active', true);

      var sitters = rows
          .map((row) => HomeBoardingListItemModel.fromJson(row).toEntity())
          .toList();

      sitters = _applySort(sitters, sortOption);

      final query = searchQuery?.trim().toLowerCase();
      if (query != null && query.isNotEmpty) {
        sitters = sitters
            .where(
              (s) =>
                  s.name.toLowerCase().contains(query) ||
                  s.specialty.toLowerCase().contains(query) ||
                  s.areaText.toLowerCase().contains(query),
            )
            .toList();
      }

      return Success(sitters);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<HomeBoardingDetailEntity, Object>> getSitterDetail({
    required String sitterId,
  }) async {
    try {
      final row = await _supabase
          .from('home_boarding_profiles')
          .select(_sitterDetailSelect)
          .eq('id', sitterId)
          .eq('is_active', true)
          .single();

      return Success(HomeBoardingDetailModel.fromJson(row).toEntity());
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  List<HomeBoardingListItemEntity> _applySort(
    List<HomeBoardingListItemEntity> sitters,
    SortOption sortOption,
  ) {
    final sorted = [...sitters];
    switch (sortOption) {
      case SortOption.topRated:
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
      case SortOption.lowestPrice:
        sorted.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
      case SortOption.mostExperienced:
        sorted.sort((a, b) => b.yearsExperience.compareTo(a.yearsExperience));
      case SortOption.recommended:
      case SortOption.nearest:
        break;
    }
    return sorted;
  }

  @override
  Future<Result<BoardingRequestEntity?, Object>> getPendingRequest({
    required String sitterId,
  }) async {
    try {
      final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Error('User not found');
      }

      final row = await _supabase
          .from('boarding_requests')
          .select()
          .eq('sitter_id', sitterId)
          .eq('requester_id', userId)
          .eq('status', 'pending')
          .maybeSingle();

      if (row == null) return const Success(null);
      return Success(BoardingRequestModel.fromJson(row));
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<BoardingRequestEntity, Object>> sendBoardingRequest({
    required String sitterId,
  }) async {
    try {
      final userId = AuthHelper.getUserId() ?? _supabase.auth.currentUser?.id;
      if (userId == null) {
        return const Error('User not found');
      }

      final row = await _supabase
          .from('boarding_requests')
          .insert({'sitter_id': sitterId, 'requester_id': userId})
          .select()
          .single();

      return Success(BoardingRequestModel.fromJson(row));
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
