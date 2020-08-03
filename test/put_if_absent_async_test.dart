import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  test('Call async function for empty map', () async {
    var emptyMap = <String, String>{};
    expect(emptyMap.containsKey('test'), isFalse);
    var item = await emptyMap.putIfAbsentAsync('test', () async {
      await Future.delayed(Duration(milliseconds: 1500));
      return 'Random String';
    });
    expect(emptyMap, isNotEmpty);
    expect(emptyMap.containsKey('test'), isTrue);
    expect(item, 'Random String');
  });

  test('Call async function for non empty map', () async {
    var emptyMap = <String, String>{'test': 'Older String'};
    expect(emptyMap.containsKey('test'), isTrue);
    var beforeRun = DateTime.now();
    var item = await emptyMap.putIfAbsentAsync('test', () async {
      await Future.delayed(Duration(milliseconds: 1500));
      return 'Random String';
    });
    var afterRun = DateTime.now();
    expect(emptyMap.containsKey('test'), isTrue);
    expect(item != 'Random String', isTrue);
    expect(item == 'Older String', isTrue);
    expect(afterRun.difference(beforeRun).inMilliseconds < 1500, isTrue);
  });
}
