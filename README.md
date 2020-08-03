# Overview [![Pub](https://img.shields.io/pub/v/ms_map_utils.svg)](https://pub.dartlang.org/packages/ms_map_utils)

![GitHub stars](https://img.shields.io/github/stars/Marcus-Software/ms_map_utils?style=social)

A simple lib to incremease Map with usefull functions

## Whats MS_Map_Utils do

Add usefull functions to map:

* `trim` trim all Strings in a map _it's recursive_.
* `compact` remove all MapEntries thats values is `null` _it's recursive too_.
* `reduce` iterate all items in `Map` for reduce to a unique value returned from callback `ReduceFunction` .
* `removeKeys` remove all entries that contains a key in list.
* `removeKeysExcept` remove all entries that NOT contains a key in list.
* `putIfAbsentAsync` put a item if absent or return existent value async.
* `containsKeys` check if map contains all keys of list.
* `doIfContains` do some work if map contains a key.

## Usage

Just import lib and use [extensions](https://dart.dev/guides/language/extension-methods), call the functions to starts work:

``` dart
// Don't forget to import
import 'package:ms_map_utils/ms_map_utils.dart';

Map itsAMap = {'key1' : null, 'key2' : 'just a String'};
compact(itsAMap); // Output: {'key2':'just a String'}
// or using extensions.
itsAMap.compact(); // Output: {'key2':'just a String'}
```

## trim

The function `trim` all Strings in a map _it's recursive_.

``` dart
    test('Most trim any Strings values', () {
      const mapToTrim = {
        'key1': '  random string    ',
        'key2': '       another random string       ',
        'key3': 321
      };
      expect(mapToTrim.trim(true), {
        'key1': 'random string',
        'key2': 'another random string',
        'key3': 321
      });
    });
```

see more in [test file](./test/trim_test.dart).

## compact

The function `compact` remove all MapEntries thats values is `null` _it's recursive_.

``` dart
test('Must return a new empty HashMap without null values', () {
    var mapWithNullValues = {
      'k1': null,
      'k2': null,
      'k3': null,
      'map': {
        'k1': null,
        'k2': null,
        'k3': null,
      },
      'list': [
        {
          'k1': null,
          'k2': null,
          'k3': null,
        },
        {
          'k1': null,
          'k2': null,
          'k3': null,
        },
      ]
    };
    var mapWithoutNull = compact(mapWithNullValues);
    expect(mapWithoutNull, {
      'map': {},
      'list': [{}, {}]
    });
  });
```

see more in [test file](./test/compact_test.dart).

## reduce

The function `reduce` iterate all items in `Map` for reduce to a unique value returned from callback `ReduceFunction` .

``` dart
  test('Multiplies all int values to 120', () {
    Map mapNumbers = <String, int>{
      'key1': 1,
      'key2': 2,
      'key3': 3,
      'key4': 4,
      'key5': 5,
    };
    var value = mapNumbers
        .reduce<int>((int acc, _, value) => (acc ?? 1) * (value as int));
    expect(value, 120, reason: 'Value reduced must be 120');
  });
```

see more in [test file](./test/reduce_test.dart).

## removeKeys

The function `removeKeys` remove all entries that contains a key in list.

``` dart
  test('Remove all entries that has a key in list with recursive', () {
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
```

see more in [test file](./test/remove_keys_test.dart).

## removeKeysExcept

The function `removeKeysExcept` remove all entries that NOT contains a key in list.

``` dart
  test('Remove all entries that has a key NOT in list with recursive', () {
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
    mapNumbers.removeKeysExcept(['key1', 'key2', 'map'], true);
    expect(mapNumbers.length, 3);
    expect(mapNumbers['map'].length, 2);
  });
```

see more in [test file](./test/remove_keys_except_test.dart).

## putIfAbsentAsync

The function `putIfAbsentAsync` put a item if absent or return existent value async.

``` dart
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
```

see more in [test file](./test/put_if_absent_async_test.dart).

## containsKeys

The function `containsKeys` check if map contains all keys of list.

``` dart
  test('Must return true if contains a list of keys', () {
    var listOfKeyToCheck = ['key1', 'key2'];
    var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(mapToCheck.containsKeys(listOfKeyToCheck), isTrue);
  });
```

see more in [test file](./test/contains_keys_test.dart).

## doIfContains

The function `doIfContains` will be call a callback function if the map contains a key ou else it will be a callback function `elseIf` if `elseIf` is null, null will returned.

``` dart
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
