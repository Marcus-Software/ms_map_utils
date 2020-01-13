import 'package:ms_map_utils/ms_map_utils.dart';

void main(List<String> args) {
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
}
