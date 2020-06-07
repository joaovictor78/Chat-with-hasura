import 'package:bestar_hasura/app/shared/models/menssage_model.dart';
import 'package:bestar_hasura/app/shared/models/user_model.dart';

import 'chat_repository_interface.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ChatRepository extends IChatRepository {
  final HasuraConnect _connection;

  ChatRepository(this._connection);

  @override
  Future<UserModel> getUser(String userName, String email) async {
    var query = '''
  getUser($userName:String!){
     query MyQuery {
       user(where: {name: {_eq: ""}}) {
         email
         id
         name
     }
   }
}
  ''';
    var data = await _connection.query(query, variables: {"name": userName});
    if (data["data"]["users"].isEmpty) {
      return createUser(userName, email);
    } else {
      UserModel userModel = UserModel.fromJson(data["data"]["users"][0]);
      return userModel;
    }
  }

  @override
  Future<UserModel> createUser(String name, String email) async {
    var query = '''
    mutation createUser {
    insert_user(objects: {email: $email, name: $name}){
    returning {
      id
    }

  }
  }
  ''';
    var data = await _connection.mutation(query, variables: {"name": name, "email" : email});
    return data;
  }

  @override
  Stream<List<MessageModel>> getMenssage() {
    var query = """
      subscription {
        messages(order_by: {id: desc}) {
          content
          id
          user {
            name
            id
          }
        }
      }
    """;

    Snapshot snapshot = _connection.subscription(query);
    return snapshot.map(
      (jsonList) => MessageModel.fromJsonList(jsonList["data"]["messages"]),
    );
  }

  @override
  Future<dynamic> sendMenssage(String message, String userId) {
    var query = """
      sendMessage(\$message:String!,\$userId:Int!) {
        insert_messages(objects: {id_usuario: \$userId, content: \$message}) {
          affected_rows
        }
      }
    """;

    return _connection.mutation(query, variables: {
      "message": message,
      "userId": userId,
    });
  }
}
