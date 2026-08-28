import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_detail_model.dart';
import 'package:rifq_v2/features/hotel/data/models/hotel_list_item_model.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_detail_entity.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseHotelDataSource {
  Future<Result<List<HotelListItemEntity>, Object>> getHotels();

  Future<Result<HotelDetailEntity, Object>> getHotelDetail({
    required String hotelId,
  });
}

@LazySingleton(as: BaseHotelDataSource)
class HotelDataSource implements BaseHotelDataSource {
  const HotelDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  static const _hotelListSelect =
      'id, name, rating, review_count, location_text, latitude, longitude, '
      'hotel_images(id, image_url, display_order, is_primary), '
      'hotel_rooms(id, name, price_per_night, size_text, includes, available_rooms), '
      'hotel_services(id, name, price, price_unit)';

  static const _hotelDetailSelect =
      'id, name, location_text, latitude, longitude, description, '
      'hotel_images(id, image_url, display_order, is_primary), '
      'hotel_rooms(id, name, price_per_night, size_text, includes, available_rooms), '
      'hotel_services(id, name, price, price_unit), '
      'hotel_facilities(id, category, name), '
      'hotel_rules(id, rule_text)';

  @override
  Future<Result<List<HotelListItemEntity>, Object>> getHotels() async {
    try {
      final rows = await _supabase
          .from('pet_hotels')
          .select(_hotelListSelect)
          .order('name');

      final position = await _currentPositionOrNull();

      final hotels = rows.map((row) {
        final model = HotelListItemModel.fromJson(row);
        final distanceKm = _distanceKmOrNull(
          from: position,
          toLat: model.latitude,
          toLng: model.longitude,
        );
        return model.toEntity(distanceKm: distanceKm);
      }).toList();

      return Success(hotels);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<HotelDetailEntity, Object>> getHotelDetail({
    required String hotelId,
  }) async {
    try {
      final row = await _supabase
          .from('pet_hotels')
          .select(_hotelDetailSelect)
          .eq('id', hotelId)
          .single();

      return Success(HotelDetailModel.fromJson(row).toEntity());
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  double? _distanceKmOrNull({
    required Position? from,
    required double? toLat,
    required double? toLng,
  }) {
    if (from == null || toLat == null || toLng == null) return null;
    return Geolocator.distanceBetween(
          from.latitude,
          from.longitude,
          toLat,
          toLng,
        ) /
        1000;
  }

  /// Best-effort device position for the list screen's distance column.
  /// Never throws — permission denial or a disabled location service just
  /// means every hotel's distance is omitted, not an error state.
  Future<Position?> _currentPositionOrNull() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
    } catch (_) {
      return null;
    }
  }
}
