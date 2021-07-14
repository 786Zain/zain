import 'package:auto_route/auto_route.dart';

class AppNavigator {
  static push(className) {
    ExtendedNavigator.root.push(className);
  }

  static pp(className) {
    ExtendedNavigator.root.popAndPush(className);
  }

  static popUntil(className){
    ExtendedNavigator.root.popUntilRoot();
  }

  static pop(){
    ExtendedNavigator.root.pop();
  }
}
