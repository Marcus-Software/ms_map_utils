import 'package:ms_map_utils/ms_map_utils.dart';

void main(List<String> args) {
  // Compat a Map
  print({'key1': null, 'key2': 'Non Null Value'}.compact());

  // Trim all strings values
  print({'key1': '    Imagine random string here   '}.trim());
}
