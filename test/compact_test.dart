import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:test/test.dart';

void main() {
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
  test('Must return a new HashMap without null values', () {
    var mapWithNullValues = {
      'k1': null,
      'k2': null,
      'k3': null,
      'k4': 'any value'
    };
    var mapWithoutNull = compact(mapWithNullValues);
    expect(mapWithoutNull.length, 1);
    expect(mapWithoutNull, {'k4': 'any value'});
  });
  test('Must return a new HashMap without null values', () {
    var mapWithNullValues = {
      'k1': null,
      'k2': null,
      'k3': null,
      'k4': 'any value'
    };
    var mapWithoutNull = mapWithNullValues.compact(true);
    expect(mapWithoutNull.length, 1);
    expect(mapWithoutNull, {'k4': 'any value'});
  });
}
