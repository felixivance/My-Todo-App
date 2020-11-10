import 'package:flutter_driver/driver_extension.dart';
import 'package:todo_app/main.dart' as app;

void main(){

  enableFlutterDriverExtension();

  //the widget you want to test
  app.main();
}

//to run this app you run
// flutter drive --target=test_driver/app.dart