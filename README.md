# Overview [![Pub](https://img.shields.io/pub/v/ms_map_utils.svg)](https://pub.dartlang.org/packages/ms_map_utils) ![GitHub stars](https://img.shields.io/github/stars/Marcus-Software/ms_map_utils?style=social)

A simple lib to incremease Map with usefull functions

## Whats MS_Map_Utils do

Add usefull functions to map:

- `trim` trim all Strings in a map _it's recursive_
- `compact` remove all MapEntries thats values is `null` _it's recursive too_
- `reduce` iterate all items in `Map` for reduce to a unique value returned from callback `ReduceFunction`.
- `removeKeys` remove all entries that contains a key in list.
- `removeKeysExcept` remove all entries that NOT contains a key in list.
- `putIfAbsentAsync` put a item if absent or return existent value async.
- `containsKeys` check if map contains all keys of list.
- `doIfContains` do some work if map contains a key.

## Usage

Just import lib and use [extensions](https://dart.dev/guides/language/extension-methods), call the functions to starts work:

```dart
import 'package:ms_map_utils/ms_map_utils.dart';

Map itsAMap = {'key1':null,'key2':'         just a String withs extras spaces en start and end            '};
itsAMap.compact(); // Output: {'key2':'         just a String withs extras spaces en start and end            '}
itsAMap.trim(); // Output: {'key2':'just a String withs extras spaces en start and end'}

Map mapNumbers = {'key1':50,'key2':7,'key3':71,'key4':45,'key5':5};
// In reduceFunction you must check if `accumulated` is null and set a initial value for it
mapNumbers.reduce<int>((int accumulated, _, value) => (accumulated ?? 0) + (value as int)); // Output 178
mapNumbers.removeKeys(['key1','key5']); //{'key2':7,'key3':71,'key4':45}
mapNumbers.removeKeysExcept(['key3']); //{'key3':71}
var item = await anyMap.putIfAbsentAsync('randomKey', () async {
        await Future.delayed(Duration(milliseconds: 1500));
        return 'Random Value';
      });
if (mapNumbers.containsKeys(['key1','key2'])) {
  print('The map contians all keys [key1, key2]');
}
```

### doIfContains

The function `doIfContains` will be call a callback function if the map contains a key ou else it will be a callback function `elseIf` if `elseIf` is null, null will returned.

```dart
  test('must return a object if contains a key', () {
    final testMap = {'key1': 'value1', 'key2': 'value2'};
    final newThing = doIfContains<List<String>>(testMap, 'key2',
        doWork: (key, value) =>
            [value.toString(), 'new awesome thing', key.toString()],
        elseIf: () => ['nothing']);
    expect(newThing, ['value2', 'new awesome thing', 'key2']);
  });
```

see more in [test file](./test/do_if_contains_test.dart).
