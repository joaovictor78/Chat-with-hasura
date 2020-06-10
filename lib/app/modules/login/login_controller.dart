import 'package:bestar_hasura/app/shared/repositories/chat_repository_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../app_controller.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
final IChatRepository chatRepository;
final controllerApp = Modular.get<AppController>();
var user;
String name;
String email;
  _LoginControllerBase(this.chatRepository);
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

getName(String value) {
  name = value;
}
getEmail(String value){
  email = value;
}
}
