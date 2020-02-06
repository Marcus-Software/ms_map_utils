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
      expect(value, 'key1key2key3key4key5', reason: "Value reduced must be 'key1key2key3key4key5'");
    });
  });
}
