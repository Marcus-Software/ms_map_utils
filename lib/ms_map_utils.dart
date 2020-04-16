part './functions/compact.dart';
part './functions/contains_keys.dart';
part './functions/put_if_absent_async.dart';
part './functions/reduce.dart';
part './functions/remove_keys.dart';
part './functions/trim.dart';

Function _compact = compact;
Function _trim = trim;
Function _reduce = reduce;
Function _removeKeys = removeKeys;
Function _removeKeysExcept = removeKeysExcept;
Function _putIfAbsentAsync = putIfAbsentAsync;
bool Function(Map map, List keys, {ContainsKeysRules rule}) _containsKeys =
    containsKeys;

extension MapUtils<K, V> on Map<K, V> {
  /// Remove all entries that value is null
  ///
  /// [newMap] if true return a new map modifield
  Map compact([bool newMap = false]) => _compact(this, newMap) as Map;

  /// Apply trim in all String values on tree
  ///
  /// [newMap] if true return a new map modifield
  Map trim([bool newMap = false]) => _trim(this, newMap) as Map;

  /// Reduce
  Tp reduce<Tp>(ReduceFunction<Tp> reduceFunction) =>
      _reduce<Tp>(this, reduceFunction) as Tp;

  /// Remove all values that matches in list of keys
  ///
  /// [keys] a list keys to be removed on map
  /// [recursive] if true seach for keys in three
  void removeKeys(List keys, [bool recursive = false]) =>
      _removeKeys(this, keys, recursive);

  /// Remove all values *except* that matches in list of keys
  ///
  /// [keys] a list keys to be keep on map
  /// [recursive] if true seach for keys in three
  void removeKeysExcept(List keys, [bool recursive = false]) =>
      _removeKeysExcept(this, keys, recursive);

  /// Return a value if it exists in map or call [ifAbsent] that's return a new value
  /// and insert him on map
  Future putIfAbsentAsync<V>(String key, Future<V> Function() ifAbsent) async =>
      _putIfAbsentAsync(this, key, ifAbsent);

  /// Return true if map contains all keys in list of keys
  bool containsKeys(List<Object> keys,
          {ContainsKeysRules rule = ContainsKeysRules.none}) =>
      _containsKeys(this, keys, rule: rule);
}
