part of '../ms_map_utils.dart';

typedef ReduceFunction<F> = F Function(
    F? accumulated, dynamic currentKey, dynamic currentValue);

/// Reduce function
T? reduce<T>(Map map, ReduceFunction<T> reduceFunction) {
  T? accumulated;
  map.forEach((key, value) {
    accumulated = reduceFunction(accumulated, key, value);
  });
  return accumulated;
}
