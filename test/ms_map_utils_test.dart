import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
  group("Compact Map", () {
    test('Must return a new empty HashMap without null values', () {
      var mapWithNullValues = {
        "k1": null,
        "k2": null,
        "k3": null,
        'map': {
          "k1": null,
          "k2": null,
          "k3": null,
        },
        'list': [
          {
            "k1": null,
            "k2": null,
            "k3": null,
          },
          {
            "k1": null,
            "k2": null,
            "k3": null,
          },
        ]
      };
      var mapWithoutNull = compact(mapWithNullValues);
      expect(mapWithoutNull, {
        'map': {},
        'list': [{}, {}]
      });
    });
    test('Must return a new HashMap without null values', () {
      var mapWithNullValues = {
        "k1": null,
        "k2": null,
        "k3": null,
        "k4": "any value"
      };
      var mapWithoutNull = compact(mapWithNullValues);
      expect(mapWithoutNull.length, 1);
      expect(mapWithoutNull, {"k4": "any value"});
    });
    test('Must return a new HashMap without null values', () {
      var mapWithNullValues = {
        "k1": null,
        "k2": null,
        "k3": null,
        "k4": "any value"
      };
      var mapWithoutNull = mapWithNullValues.compact(true);
      expect(mapWithoutNull.length, 1);
      expect(mapWithoutNull, {"k4": "any value"});
    });
  });
  group("Trim Strings on map", () {
    test("Most trim any Strings values", () {
      const mapToTrim = {
        "key1": "  random string    ",
        "key2": "       another random string       ",
        "key3": 321
      };
      expect(mapToTrim.trim(true), {
        "key1": "random string",
        "key2": "another random string",
        "key3": 321
      });
    });
    test("Most trim any Strings values and map enhered", () {
      const mapToTrim = {
        "key1": "  random string    ",
        "key2": "       another random string       ",
        "map": {
          "key1": "  random string    ",
          "key2": "       another random string       ",
          "map": {
            "key1": "  random string    ",
            "key2": "       another random string       ",
          }
        }
      };
      expect(mapToTrim.trim(true), {
        "key1": "random string",
        "key2": "another random string",
        "map": {
          "key1": "random string",
          "key2": "another random string",
          "map": {
            "key1": "random string",
            "key2": "another random string",
          }
        }
      });
    });
  });
  group("Must trim list with maps", () {
    test("Trim a map with a list of maps", () {
      var mapToTrim = {
        "key": [
          {"key": " random string  "},
          {"key": "   another random string      "},
          {"key": "  last random string    "},
        ]
      };
      expect(mapToTrim.trim(true), {
        "key": [
          {"key": "random string"},
          {"key": "another random string"},
          {"key": "last random string"},
        ]
      });
    });
  });

  group('Must reduce a map to unique value', () {
    test('Sum all int values to 178', () {
      Map mapNumbers = <String, int>{
        'key1': 50,
        'key2': 7,
        'key3': 71,
        'key4': 45,
        'key5': 5,
      };
      var value = mapNumbers
          .reduce<int>((int acc, _, value) => (acc ?? 0) + (value as int));
      expect(value, 178, reason: "Value reduced must be 178");
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
          .reduce<int>((int acc, _, value) => (acc ?? 1) * (value as int));
      expect(value, 120, reason: "Value reduced must be 120");
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
          .reduce<String>((String acc, key, _) => (acc ?? '') + key.toString());
      expect(value, 'key1key2key3key4key5',
          reason: "Value reduced must be 'key1key2key3key4key5'");
    });
  });

  group('RemoveKeysExcept', () {
    test('Remove all entries that has a key NOT in list', () {
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
      mapNumbers.removeKeysExcept(['key1', 'key2', 'map']);
      expect(mapNumbers.length, 3);
      expect(mapNumbers['map'].length, 5);
    });
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
  });

  group('RemoveKeys', () {
    test('Remove all entries that has a key in list', () {
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
  });

  group('Put if absent async', () {
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
  });

  group('Contains a lot of keys', () {
    test('Must return true if contains a list of keys', () {
      var listOfKeyToCheck = ['key1', 'key2'];
      var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
      expect(mapToCheck.containsKeys(listOfKeyToCheck), isTrue);
    });
    test('Must return false if not contains a key in list', () {
      var listOfKeyToCheck = ['key1', 'key4'];
      var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
      expect(mapToCheck.containsKeys(listOfKeyToCheck), isFalse);
    });

    test('Must return true if contains only keys in list', () {
      var listOfKeyToCheck = ['key1', 'key2'];
      var mapToCheck = {'key1': 'value1', 'key2': 'value2'};
      expect(
          mapToCheck.containsKeys(listOfKeyToCheck,
              rule: ContainsKeysRules.only),
          isTrue);
    });

    test('Must return false if contains only keys in list', () {
      var listOfKeyToCheck = ['key1', 'key2'];
      var mapToCheck = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
      expect(
          mapToCheck.containsKeys(listOfKeyToCheck,
              rule: ContainsKeysRules.only),
          isFalse);
    });
  });
}
