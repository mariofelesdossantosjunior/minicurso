import 'package:hasura_connect/hasura_connect.dart';
import 'package:mini_curso_flutter/shared/model/message_model.dart';
import 'package:mini_curso_flutter/shared/model/user_model.dart';

class ServiceHasura {
  static const BASE_URL = "https://mini-curso.herokuapp.com/v1/graphql";
  static HasuraConnect connection = new HasuraConnect(BASE_URL);

  Future<UserModel> login(String name) async {
    var query = """
      mutation addUser(
        \$name: String!
        ){
          insert_user(objects: {name: \$name}) {
            returning {
              id
              name
            }
          }
        }
    """;
    var data = await connection.mutation(query, variables: {"name": name});
    return UserModel.fromJson(data["data"]["insert_user"]["returning"][0]);
  }

  Stream<List<MessageModel>> getMessages() {
    var query = """
    subscription {
      message {
        id
        message
        user {
          id
          name
        }
      }
    }
    """;
    var data = connection.subscription(query);
    return data.stream
        .map((json) => MessageModel.fromJsonList(json["data"]["message"]));
  }

  Future<bool> sendMessage(int id_user, String message) async {
    var query = """
      mutation addMessage(
        \$id_user: Int!,
        \$message: String!
        ){
          insert_message(objects: {id_user: \$id_user, message: \$message }) {
            affected_rows
          }
        }
    """;
    var data = await connection
        .mutation(query, variables: {"id_user": id_user, "message": message});
    return data["data"]["insert_message"]["affected_rows"] == 1;//Sucess
  }
}
