import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
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

  test('Most trim any Strings values and map enhered', () {
    const mapToTrim = {
      'key1': '  random string    ',
      'key2': '       another random string       ',
      'map': {
        'key1': '  random string    ',
        'key2': '       another random string       ',
        'map': {
          'key1': '  random string    ',
          'key2': '       another random string       ',
        }
      }
    };
    expect(mapToTrim.trim(true), {
      'key1': 'random string',
      'key2': 'another random string',
      'map': {
        'key1': 'random string',
        'key2': 'another random string',
        'map': {
          'key1': 'random string',
          'key2': 'another random string',
        }
      }
    });
  });

  test('Trim a map with a list of maps', () {
    var mapToTrim = {
      'key': [
        {'key': ' random string  '},
        {'key': '   another random string      '},
        {'key': '  last random string    '},
      ]
    };
    expect(mapToTrim.trim(true), {
      'key': [
        {'key': 'random string'},
        {'key': 'another random string'},
        {'key': 'last random string'},
      ]
    });
  });
}
