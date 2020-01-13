# Overview

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
```
