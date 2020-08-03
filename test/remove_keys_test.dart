import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('Remove all entries that has a key in list', () {
    // ignore: omit_local_variable_types
    Map mapNumbers = {
      'key1': 1,
      'key2': 2,
      'key3': 3,
      'key4': 4,
      'key5': 5,
      'map': {
        'key1': 1,
        'key2': 2,
        'key3': 3,
        'key4': 4,
        'key5': 5,
      }
    };
    mapNumbers.removeKeys(['key1', 'key2']);
    expect(mapNumbers.length, 4);
    expect(mapNumbers['map'].length, 5);
  });
  test('Remove all entries that has a key in list with recursive', () {
    // ignore: omit_local_variable_types
    Map mapNumbers = {
      'key1': 1,
      'key2': 2,
      'key3': 3,
      'key4': 4,
      'key5': 5,
      'map': {
        'key1': 1,
        'key2': 2,
        'key3': 3,
        'key4': 4,
        'key5': 5,
      }
    };
    mapNumbers.removeKeys(['key1', 'key2'], true);
    expect(mapNumbers.length, 4);
    expect(mapNumbers['map'].length, 3);
  });
}
