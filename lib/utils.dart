import 'package:basic_utils/basic_utils.dart';

class Utils {
  static getCapitalizeName(name) {
    return "${name.trim().split("  ").join(" ").split(" ").map((e) => StringUtils.capitalize(e)).join(' ')}";
  }
}
