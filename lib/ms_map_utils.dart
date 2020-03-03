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

/// Reduce functions
T reduce<T>(Map map, ReduceFunction<T> reduceFunction) {
  T accumulated;
  map.forEach((key, value) {
    accumulated = reduceFunction(accumulated, key, value);
  });
  return accumulated;
}

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

Future putIfAbsentAsync<V>(Map map, String key, Future<V> ifAbsent()) async {
  if (map.containsKey(key)) {
    return map[key];
  } else {
    var value = await ifAbsent();
    map[key] = value;
    return value;
  }
}

Function _compact = compact;
Function _trim = trim;
Function _reduce = reduce;
Function _removeKeys = removeKeys;
Function _removeKeysExcept = removeKeysExcept;
Function _putIfAbsentAsync = putIfAbsentAsync;

extension of on Map {
  Map compact([bool newMap = false]) => _compact(this, newMap) as Map;

  Map trim([bool newMap = false]) => _trim(this, newMap) as Map;

  Tp reduce<Tp>(ReduceFunction<Tp> reduceFunction) =>
      _reduce<Tp>(this, reduceFunction) as Tp;

  void removeKeys(List keys, [bool recursive = false]) =>
      _removeKeys(this, keys, recursive);

  void removeKeysExcept(List keys, [bool recursive = false]) =>
      _removeKeysExcept(this, keys, recursive);

  Future putIfAbsentAsync<V>(String key, Future<V> ifAbsent()) async =>
      _putIfAbsentAsync(this, key, ifAbsent);
}
