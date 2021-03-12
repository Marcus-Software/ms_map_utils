part of '../ms_map_utils.dart';

/// Return a value if it exists in map or call [ifAbsent] that's return a new value
/// and insert him on map
Future<V?> putIfAbsentAsync<V>(
    Map<dynamic, V> map, String key, Future<V> Function() ifAbsent) async {
  if (map.containsKey(key)) {
    return map[key];
  } else {
    var value = await ifAbsent();
    map[key] = value;
    return value;
  }
}
