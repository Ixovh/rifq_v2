import 'package:get_storage/get_storage.dart';

/// Locally persisted list of recent search queries, most-recent-first.
class RecentSearchesStore {
  RecentSearchesStore._();

  static final _box = GetStorage();
  static const _key = 'recent_searches';
  static const _maxEntries = 10;

  static List<String> read() {
    final data = _box.read(_key);
    if (data is! List) return [];
    return data.cast<String>();
  }

  static Future<void> add(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final current = read()
        .where((q) => q.toLowerCase() != trimmed.toLowerCase())
        .toList();
    current.insert(0, trimmed);

    await _box.write(_key, current.take(_maxEntries).toList());
  }

  static Future<void> remove(String query) async {
    final current = read().where((q) => q != query).toList();
    await _box.write(_key, current);
  }

  static Future<void> clear() => _box.remove(_key);
}
