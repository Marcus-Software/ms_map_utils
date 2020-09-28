import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('must return a new map with differences in values', () {
    var fromMap = {'key1': 'value1', 'key2': 'value diff', 'key3': 'value3'};
    var toMap = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(diff(fromMap, toMap), {'key2': 'value2'});
    expect(toMap, {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'});
    expect(fromMap, {'key1': 'value1', 'key2': 'value diff', 'key3': 'value3'});
  });

  test('must return a new map with differences in values and MapSize', () {
    var fromMap = {'key1': 'value1', 'key2': 'value diff'};
    var toMap = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(diff(fromMap, toMap), {'key2': 'value2', 'key3': 'value3'});
  });

  test('must return a new map empty if no differences', () {
    var fromMap = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    var toMap = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(diff(fromMap, toMap), {});
  });

  test(
      'must return a new map with differences in values with differences is in nested map',
      () {
    var fromMap = {
      'key1': 'value1',
      'nestedMap': {'key2': 'value2', 'key3': 'value3'},
      'otherNestedMap': {'randomKey': []}
    };
    var toMap = {
      'key1': 'value1',
      'nestedMap': {'key2': 123, 'key3': 'value3'},
      'otherNestedMap': 'random value'
    };
    expect(diff(fromMap, toMap), {
      'nestedMap': {'key2': 123},
      'otherNestedMap': 'random value'
    });
  });

  test(
      'must return a new map with differences in values with differences skipping nested map',
      () {
    var fromMap = {
      'key1': 'value1',
      'nestedMap': {'key2': 'value2', 'key3': 'value3'},
      'otherNestedMap': {'randomKey': []}
    };
    var toMap = {
      'key1': 'value1',
      'nestedMap': {'key2': 123, 'key3': 'value3'},
      'otherNestedMap': 'random value'
    };
    expect(diff(fromMap, toMap, true), {
      'nestedMap': {'key2': 123, 'key3': 'value3'},
      'otherNestedMap': 'random value'
    });
  });
}
