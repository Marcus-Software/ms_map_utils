# Overview [![Pub](https://img.shields.io/pub/v/ms_map_utils.svg)](https://pub.dartlang.org/packages/ms_map_utils)![GitHub stars](https://img.shields.io/github/stars/Marcus-Software/ms_map_utils?style=social)

A simple lib to incremease Map with usefull functions

## Whats MS_Map_Utils do

Add usefull functions to map:

- `trim` trim all Strings in a map _it's recursive_
- `compact` remove all MapEntries thats values is `null` _it's recursive too_

## Usage

Just import lib and use [extensions](https://dart.dev/guides/language/extension-methods), call the functions to starts work:

```dart
import 'package:ms_map_utils/ms_map_utils.dart';

Map itsAMap = {'key1':null,'key2':'         just a String withs extras spaces en start and end            '};
itsAMap.compact(); // Output: {'key2':'         just a String withs extras spaces en start and end            '}
itsAMap.trim(); // Output: {'key2':'just a String withs extras spaces en start and end'}

Map mapNumbers = {'key1':50,'key2':7,'key3':71,'key4':45,'key5':5};
// In reduceFunction you must check is acc is null and set a initial value for it
mapNumbers.reduce<int>((int accumulated, _, value) => (accumulated ?? 0) + (value as int)); // Output 178
```
