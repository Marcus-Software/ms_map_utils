part of '../ms_map_utils.dart';

/// Apply trim in all String values on tree
///
/// [map] map to trim
/// [newMap] if true return a new map modifield
Map trim(Map map, [bool newMap = false]) {
  return (newMap ? Map.from(map) : map).map((key, value) {
    var tmpValue = value;
    if (value is String) {
      tmpValue = value.trim();
    } else if (value is Map) {
      tmpValue = trim(value);
    } else if (value is List<Map>) {
      tmpValue = value.cast<Map>().map((vMap) => trim(vMap, newMap)).toList();
    }
    return MapEntry(key, tmpValue);
  });
}
