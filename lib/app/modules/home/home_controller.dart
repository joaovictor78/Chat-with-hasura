import 'package:bestar_hasura/app/shared/models/menssage_model.dart';
import 'package:bestar_hasura/app/shared/repositories/chat_repository.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  ChatRepository _chatRepository;
  String message;
  @observable
  AppController  _appController;
  _HomeControllerBase(this._chatRepository, this._appController){
   
  }
  @observable
  ObservableStream<List<MessageModel>> messages;
  @action
  getMensagens(){
  messages = _chatRepository.getMenssage().asObservable();
  return messages;
  }
   void getMessage(String value) {
     message = value;
  }
  void sendMessage(){
    _chatRepository.sendMenssage(message, '${_appController.userController.id}');
  }
}
