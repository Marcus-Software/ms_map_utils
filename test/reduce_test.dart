import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('Sum all int values to 178', () {
    Map mapNumbers = <String, int>{
      'key1': 50,
      'key2': 7,
      'key3': 71,
      'key4': 45,
      'key5': 5,
    };
    var value = mapNumbers
        .reduce<int>((int? acc, _, value) => (acc ?? 0) + (value as int));
    expect(value, 178, reason: 'Value reduced must be 178');
  });

  test('Multiplies all int values to 120', () {
    Map mapNumbers = <String, int>{
      'key1': 1,
      'key2': 2,
      'key3': 3,
      'key4': 4,
      'key5': 5,
    };
    var value = mapNumbers
        .reduce<int>((int? acc, _, value) => (acc ?? 1) * (value as int));
    expect(value, 120, reason: 'Value reduced must be 120');
  });

  test('Concat all keys to "key1key2key3key4key5"', () {
    Map mapNumbers = <String, int>{
      'key1': 1,
      'key2': 2,
      'key3': 3,
      'key4': 4,
      'key5': 5,
    };
    var value = mapNumbers
        .reduce<String>((String? acc, key, _) => (acc ?? '') + key.toString());
    expect(value, 'key1key2key3key4key5',
        reason: 'Value reduced must be "key1key2key3key4key5"');
  });
}
