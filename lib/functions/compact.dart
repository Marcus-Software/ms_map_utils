part of '../ms_map_utils.dart';

  /// Remove all entries that value is null
  ///
  /// [map] map to compact
  /// [newMap] if true return a new map modifield
Map<K, V> compact<K, V>(Map map, [bool newMap = false]) =>
    (newMap ? Map<K, V>.from(map) : map).cast<K, V>()
      ..removeWhere((_, value) {
        if (value is Map && value != null) {
          compact(value, newMap);
        } else if (value is List<Map> && value != null) {
          value.forEach((mapInList) {
            compact(mapInList, newMap);
          });
        }
        return value == null;
      });