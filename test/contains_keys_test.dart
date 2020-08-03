import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('Must return true if contains a list of keys', () {
    var listOfKeyToCheck = ['key1', 'key2'];
    var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(mapToCheck.containsKeys(listOfKeyToCheck), isTrue);
  });
  test('Must return false if not contains a key in list', () {
    var listOfKeyToCheck = ['key1', 'key4'];
    var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(mapToCheck.containsKeys(listOfKeyToCheck), isFalse);
  });

  test('Must return true if contains only keys in list', () {
    var listOfKeyToCheck = ['key1', 'key2'];
    var mapToCheck = {'key1': 'value1', 'key2': 'value2'};
    expect(
        mapToCheck.containsKeys(listOfKeyToCheck, rule: ContainsKeysRules.only),
        isTrue);
  });

  test('Must return false if contains only keys in list', () {
    var listOfKeyToCheck = ['key1', 'key2'];
    var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(
        mapToCheck.containsKeys(listOfKeyToCheck, rule: ContainsKeysRules.only),
        isFalse);
  });
}
