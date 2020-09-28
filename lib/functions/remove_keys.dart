part of '../ms_map_utils.dart';

/// Remove all values that matches in list of keys
///
/// [keys] a list keys to be removed on map
/// [recursive] if true seach for keys in three
void removeKeys(Map map, List keys, [bool recursive = false]) {
  map.removeWhere((key, value) {
    if (keys.contains(key)) {
      return true;
    } else if (value is Map && recursive) {
      removeKeys(value, keys, recursive);
    }
    return false;
  });
}

/// Remove all values *except* that matches in list of keys
///
/// [keys] a list keys to be keep on map
/// [recursive] if true seach for keys in three
void removeKeysExcept(Map map, List keys, [bool recursive = false]) {
  map.removeWhere((key, value) {
    if (keys.contains(key)) {
      if (value is Map && recursive) {
        removeKeysExcept(value, keys, recursive);
      }
      return false;
    }
    return true;
  });
}
