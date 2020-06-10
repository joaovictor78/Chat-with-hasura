import 'package:bestar_hasura/app/shared/models/menssage_model.dart';
import 'package:bestar_hasura/app/shared/models/user_model.dart';

abstract class IChatRepository{
  Future<UserModel> getUser(String userName, String email);
  Future<UserModel> createUser(String name, String email);
  Stream<List<MessageModel>> getMenssage();
  Future<dynamic> sendMenssage(String menssage, String userId);
}