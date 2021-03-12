part of '../ms_map_utils.dart';

/// Return true if map contains all keys in list of keys
bool containsKeys(Map<dynamic, dynamic> map, List<Object> listOfKey,
    {ContainsKeysRules? rule = ContainsKeysRules.none}) {
  return _functions[rule ?? ContainsKeysRules.none]!(map, listOfKey);
}

enum ContainsKeysRules { none, only }

bool _noneFun(Map map, List listOfKeys) {
  return listOfKeys
      .map((obj) => map.containsKey(obj))
      .reduce((b1, b2) => b1 && b2);
}

bool _onlyFun(Map map, List listOfKeys) {
  if (map.length == listOfKeys.length) {
    var setKeys = <dynamic>{...map.keys, ...listOfKeys};
    return setKeys.length == listOfKeys.length;
  }
  return false;
}

Map<ContainsKeysRules, bool Function(Map, List)> _functions = {
  ContainsKeysRules.none: _noneFun,
  ContainsKeysRules.only: _onlyFun
};
