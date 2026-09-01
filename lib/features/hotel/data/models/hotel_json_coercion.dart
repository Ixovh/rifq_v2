Map<String, dynamic> coerceHotelJson(Map<String, dynamic> json) {
  final copy = Map<String, dynamic>.from(json);
  if (copy.containsKey('rating')) {
    copy['rating'] = toDouble(copy['rating']) ?? 0;
  }
  copy['hotel_rooms'] = coerceMappedList(copy['hotel_rooms'], (row) {
    row['price_per_night'] = toDouble(row['price_per_night']) ?? 0;
    return row;
  });
  copy['hotel_services'] = coerceMappedList(copy['hotel_services'], (row) {
    if (row.containsKey('price')) {
      row['price'] = toDouble(row['price']);
    }
    return row;
  });
  return copy;
}

List<Map<String, dynamic>> coerceMappedList(
  dynamic value,
  Map<String, dynamic> Function(Map<String, dynamic> row) mapRow,
) {
  if (value is! List) return const [];
  return [
    for (final item in value)
      if (item is Map)
        mapRow(Map<String, dynamic>.from(item))
      else
        <String, dynamic>{},
  ];
}

double? toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
