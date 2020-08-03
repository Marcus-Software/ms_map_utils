part of '../ms_map_utils.dart';

/// Return a result of [doWork] if a map contains a key or return
/// a result of [elseIf] if non null else will return null
T doIfContains<T>(Map map, Object key,
    {@required T Function(Object key, Object value) doWork, T Function() elseIf}) {
  assert(doWork != null, 'doWork should not be non null');
  assert(map != null, 'map should not be non null');
  if (map?.containsKey(key) == true) {
    return doWork(key, map[key]);
  } else if (elseIf != null) {
    return elseIf();
  }
  return null;
}
