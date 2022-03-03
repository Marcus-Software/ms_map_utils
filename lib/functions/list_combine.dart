part of '../ms_map_utils.dart';
/// creates an [Map] by using one array for keys and another for its values
/// [keys] a list of keys for the [Map]
/// [values] a list of values fot the [Map]
/// [return] a [Map] with keys and values combine
Map<K, V> listCombine<K, V>(List<K> keys, List<V> values) {
  if (keys.length != values.length) {
    throw Exception('keys and values must have the same number of element');
  }
  final map = <K, V>{};
  for (var i = 0; i < keys.length; i++) {
    map[keys[i]] = values[i];
  }
  return map;
}
