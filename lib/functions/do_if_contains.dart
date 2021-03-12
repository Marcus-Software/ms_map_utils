part of '../ms_map_utils.dart';

/// Return a result of [doWork] if a map contains a key or return
/// a result of [elseIf] if non null else will return null
T? doIfContains<T>(Map map, dynamic key,
    {required T Function(dynamic key, dynamic value) doWork,
    T Function()? elseIf}) {
  if (map.containsKey(key) == true) {
    return doWork(key, map[key]);
  } else if (elseIf != null) {
    return elseIf();
  }
  return null;
}
