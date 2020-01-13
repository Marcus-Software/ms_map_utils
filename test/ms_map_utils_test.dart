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
}
