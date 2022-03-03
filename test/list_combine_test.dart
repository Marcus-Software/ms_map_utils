import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('combine two list as map', () {
    final keys = ['red', 'green', 'blue', 'white', 'black'];
    final values = [0xFF0000, 0x00FF00, 0x0000FF, 0xFFFFFF, 0x000000];
    final newMap = listCombine<String, int>(keys, values);
    expect(newMap is Map<String, int>, isTrue);
    expect({
      'red': 0xFF0000,
      'green': 0x00FF00,
      'blue': 0x0000FF,
      'white': 0xFFFFFF,
      'black': 0x000000,
    }, newMap);
  });

  test('must fails when try use lists with varied sizes', () {
    try {
      final keys = ['one', 'two', 'three'];
      final values = [1, 2, 3, 4];
      listCombine(keys, values);
      expect(true, isFalse);
    } catch (e) {
      expect(e, isException);
    }
  });

  test('must fails when try use lists with varied sizes', () {
    try {
      final keys = ['one', 'two', 'three'];
      final values = [1, 2];
      listCombine(keys, values);
      expect(true, isFalse);
    } catch (e) {
      expect(e, isException);
    }
  });
}
