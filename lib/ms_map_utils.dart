/// Return a new map without null values
Map<K, V> compact<K, V>(Map map, [bool newMap = false]) =>
    (newMap ? Map<K, V>.from(map) : map)
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

/// Trim every value is a String if recursive with map and lists with map
Map<K, V> trim<K, V>(Map map, [bool newMap = false]) {
  return (newMap ? Map<K, V>.from(map) : map).map((key, value) {
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

Function _compact = compact;
Function _trim = trim;

extension of on Map {
  Map compact([bool newMap = false]) => _compact(this, newMap);

  Map trim([bool newMap = false]) => _trim(this, newMap);
}
