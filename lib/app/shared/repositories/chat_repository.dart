import 'package:bestar_hasura/app/shared/models/menssage_model.dart';
import 'package:bestar_hasura/app/shared/models/user_model.dart';
import 'chat_repository_interface.dart';
import 'package:hasura_connect/hasura_connect.dart';


class ChatRepository extends IChatRepository {
  final HasuraConnect _connection;
  ChatRepository(this._connection);

  @override
  Future<UserModel> getUser(String userName, String email) async {
    var query = r'''
    getUser($userName:String!){
       user(where: {name: {_eq: $userName}}) {
         email
         id
         name
      }
    }
  ''';
    var data = await _connection.query(query, variables: {"userName": userName});
    if (data["data"]["user"].isEmpty) {
      return createUser(userName, email);
    } else { 
      UserModel userModel = UserModel.fromJson(data["data"]["user"][0]);
      return userModel;
    }
  }

  @override
   Future<UserModel> createUser(String name, String email) async {
    var query = r"""
      mutation createUser($name:String!, $email:String!) {
        insert_user(objects: {name: $name, email: $email}) {
          returning {
            id
          }
        }
      }
    """;
    var data = await _connection.mutation(query, variables: {"name": name, "email": email});
    var id = data["data"]["insert_user"]["returning"][0]["id"];
    return UserModel(id: id, name: name, email: email);
  }

  @override
  Stream<List<MessageModel>> getMenssage() {
    var query = r"""
      subscription {
        mensagem(order_by: {id: desc}) {
          content
          id
          user {  
            name
            id
          } 
        }
      }
    """;

    Snapshot snapshot =  _connection.subscription(query);
    return snapshot.map(
      (jsonList) => MessageModel.fromJsonList(jsonList["data"]["mensagem"]),
    );
  }

  @override
  Future<dynamic> sendMenssage(String message, String userId) {
    var query = r"""
      sendMessage($message:String!, $userId:Int!) {
        insert_mensagem(objects: {id_user: $userId, content: $message}) {
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
