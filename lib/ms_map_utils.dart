part './functions/compact.dart';
part './functions/contains_keys.dart';
part './functions/diff.dart';
part './functions/do_if_contains.dart';
part './functions/put_if_absent_async.dart';
part './functions/reduce.dart';
part './functions/remove_keys.dart';
part './functions/trim.dart';
part './functions/list_combine.dart';

final _compact = compact;
final _trim = trim;
final _reduce = reduce;
final _removeKeys = removeKeys;
final _removeKeysExcept = removeKeysExcept;
final _putIfAbsentAsync = putIfAbsentAsync;
final _doIfContains = doIfContains;
final _diff = diff;
bool Function(Map<dynamic, dynamic> map, List<Object> listOfKey,
    {ContainsKeysRules? rule}) _containsKeys = containsKeys;

extension MapUtils<K, V> on Map<K, V> {
  /// Remove all entries that value is null
  ///
  /// [newMap] if true return a new map modifield
  Map compact([bool newMap = false]) => _compact(this, newMap);

  /// Apply trim in all String values on tree
  ///
  /// [newMap] if true return a new map modifield'
  Map trim([bool newMap = false]) => _trim(this, newMap);

  /// Reduce
  Tp? reduce<Tp>(ReduceFunction<Tp> reduceFunction) =>
      _reduce<Tp>(this, reduceFunction);

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
  Future<V?> putIfAbsentAsync(
          String key, Future<V> Function() ifAbsent) async =>
      _putIfAbsentAsync<V>(this, key, ifAbsent);

  /// Return true if map contains all keys in list of keys
  bool containsKeys(List<Object> keys,
          {ContainsKeysRules rule = ContainsKeysRules.none}) =>
      _containsKeys(this, keys, rule: rule);

  /// Return a result of [doWork] if a map contains a key or return
  /// a result of [elseIf] if non null else will return null
  X? doIfContains<X>(dynamic key,
          {required X Function(dynamic key, dynamic value) doWork,
          X Function()? elseIf}) =>
      _doIfContains<X>(this, key, doWork: doWork, elseIf: elseIf);

  /// Returns a new map contend only difference between maps
  /// [to] Map to compare
  /// [skipNested] If true will skip any nested map and only process if maps is equals. Defaults value is false.
  Map diff(Map to, [bool skipNested = false]) {
    return _diff(this, to, skipNested);
  }
}
