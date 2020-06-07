import 'package:bestar_hasura/app/shared/repositories/chat_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
final chatRepository = Modular.get<ChatRepository>();
final controllerApp = Modular.get<AppController>();
var user;
Future<bool> login() async{
  try {
   user = await chatRepository.getUser(name, email);
   controllerApp.userController = user;
   return true;
  } catch(e){
    print(e);
    return false;
  }
}

String name;
String email;

getName(String value) {
  name = value;
}
getEmail(String value){
  email = value;
}
}
