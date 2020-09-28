part of '../ms_map_utils.dart';

/// Returns a new map contend only difference between maps
/// [from] Reference map
/// [to] Map to compare
/// [skipNested] If true will skip any nested map and only process if maps is equals.
Map diff(Map from, Map to, [bool skipNested = false]) {
  var toClone = Map.from(to);
  var mDiff = {};
  from.forEach((key, fromValue) {
    toClone.doIfContains(
      key,
      doWork: (toKey, toValue) {
        if (!skipNested && fromValue is Map && toValue is Map) {
          mDiff[key] = diff(fromValue, toValue);
        } else if (fromValue != toValue) mDiff[key] = toValue;
        toClone.remove(key);
      },
      elseIf: () {
        mDiff[key] = fromValue;
      },
    );
  });
  return {...mDiff, ...toClone};
}
