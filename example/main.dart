import 'package:ms_map_utils/ms_map_utils.dart';

Future<void> main(List<String> args) async {
  // Compat a Map
  print({'key1': null, 'key2': 'Non Null Value'}.compact());

  // Trim all strings values
  print({'key1': '    Imagine random string here   '}.trim());

  Map justMap = {
    'key1': null,
    'key2':
        '         just a String withs extras spaces en start and end            '
  };

  // Will remove key1
  // {key2:          just a String withs extras spaces en start and end            }
  print(justMap.compact());

  // Will trim value string
  // {key2: just a String withs extras spaces en start and end}
  print(justMap.trim());

  Map mapNumbers = {'key1': 50, 'key2': 7, 'key3': 71, 'key4': 45, 'key5': 5};
  // In reduceFunction you must check is acc is null and set a initial value for it
  var sumValues = mapNumbers.reduce<int>((int accumulated, _, value) =>
      (accumulated ?? 0) + (value as int)); // Output 178
  print(sumValues);
  mapNumbers.removeKeys(['key1', 'key5']);
  print(mapNumbers);
  mapNumbers.removeKeysExcept(['key3']);
  print(mapNumbers);

  var item = await justMap.putIfAbsentAsync('randomKey', () async {
    // do hard work here
    await Future.delayed(Duration(milliseconds: 1500));
    return 'Random String';
  });
  print(item);

  if (mapNumbers.containsKeys(['key1', 'key2'])) {
    print('The map contians all keys [key1, key2]');
  }
}
