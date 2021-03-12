# Overview

[![Pub](https://img.shields.io/pub/v/ms_map_utils.svg)](https://pub.dartlang.org/packages/ms_map_utils)
[![Pub](./coverage_badge.svg)](https://github.com/Marcus-Software/ms_map_utils/tree/master/test)
[![GitHub stars](https://img.shields.io/github/stars/Marcus-Software/ms_map_utils?style=social)](https://github.com/Marcus-Software/ms_map_utils)
<span class="badge-buymeacoffee">
<a href="https://www.buymeacoffee.com/marcusedu" title="Donate to this project using Buy Me A Coffee"><img src="https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg" alt="Buy Me A Coffee donate button" /></a>
</span>


A simple lib to increase Map with useful functions

## Whats MS_Map_Utils do

Add useful functions to map:

* [`compact`](#compact) remove all MapEntries that's values is `null` _it's recursive too_.
* [`containsKeys`](#containsKeys) check if map contains all keys of list.
* [`diff`](#diff) returns a new map contend only difference between maps.
* [`doIfContains`](#doIfContains) do some work if map contains a key.
* [`putIfAbsentAsync`](#putIfAbsentAsync) put an item if absent or return existent value async.
* [`reduce`](#reduce) iterate all items in `Map` for reduce to a unique value returned from callback `ReduceFunction` .
* [`removeKeysExcept`](#removeKeysExcept) remove all entries that NOT contains a key in list.
* [`removeKeys`](#removeKeys) remove all entries that contains a key in list.
* [`trim`](#trim) trim all Strings in a map _it's recursive_.

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

## <a name="compact"></a>compact

The function `compact` remove all MapEntries that's values is `null` _it's recursive_.

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

## <a name="containsKeys"></a>containsKeys

The function `containsKeys` check if map contains all keys of list.

``` dart
  test('Must return true if contains a list of keys', () {
    var listOfKeyToCheck = ['key1', 'key2'];
    var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    expect(mapToCheck.containsKeys(listOfKeyToCheck), isTrue);
  });
```

see more in [test file](./test/contains_keys_test.dart).

## <a name="diff"></a>diff

The function `diff` returns a new map contend only difference between maps

``` dart
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
```

see more in [test file](./test/diff_test.dart).

## <a name="doIfContains"></a>doIfContains

The function `doIfContains` will be call a callback function if the map contains a key ou else it will be a callback function `elseIf` if `elseIf` is null, null will return.

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

## <a name="putIfAbsentAsync"></a>putIfAbsentAsync

The function `putIfAbsentAsync` put an item if absent or return existent value async.

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

## <a name="reduce"></a>reduce

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

## <a name="removeKeys"></a>removeKeys

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

## <a name="removeKeysExcept"></a>removeKeysExcept

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

## <a name="trim"></a>trim

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

[See another libs here](https://pub.dev/publishers/marcussoftware.info/packages)
