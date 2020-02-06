/// Return a new map without null values
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

/// Trim every value is a String if recursive with map and lists with map
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

typedef T ReduceFunction<T>(T accumulated, currentKey, currentValue);

T reduce<T>(Map map, ReduceFunction<T> reduceFunction) {
  T accumulated;
  map.forEach((key, value) {
    accumulated = reduceFunction(accumulated, key, value);
  });
  return accumulated;
}

Function _compact = compact;
Function _trim = trim;
Function _reduce = reduce;

extension of on Map {
  Map compact([bool newMap = false]) => _compact(this, newMap) as Map;

  Map trim([bool newMap = false]) => _trim(this, newMap) as Map;

  Tp reduce<Tp>(ReduceFunction<Tp> reduceFunction) =>
      _reduce<Tp>(this, reduceFunction) as Tp;
}
