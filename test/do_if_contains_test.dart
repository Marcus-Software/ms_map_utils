import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('must return a object if contains a key', () {
    final testMap = {'key1': 'value1', 'key2': 'value2'};
    final newThing = doIfContains<List<String>>(testMap, 'key2',
        doWork: (key, value) =>
            [value.toString(), 'new awesome thing', key.toString()],
        elseIf: () => ['nothing']);
    expect(newThing, ['value2', 'new awesome thing', 'key2']);
  });

  test('must return a default object if not contains a key', () {
    final testMap = {'key1': 'value1', 'key2': 'value2'};
    final newThing = doIfContains<List<String>>(testMap, 'key3',
        doWork: (key, value) =>
            [value.toString(), 'new awesome thing', key.toString()],
        elseIf: () => ['nothing']);
    expect(newThing, ['nothing']);
  });

  test(
      'must return a null if not contains a key and not pass callback to elseIf',
      () {
    final testMap = {'key1': 'value1', 'key2': 'value2'};
    final newThing = doIfContains<List<String>>(testMap, 'key3',
        doWork: (key, value) =>
            [value.toString(), 'new awesome thing', key.toString()]);
    expect(newThing, null);
  });


}
