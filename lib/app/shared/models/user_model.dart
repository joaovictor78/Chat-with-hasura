import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String name;
    String email;
    int id;

    UserModel({
        this.name,
        this.email,
        this.id
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        name: json["name"],
        email: json["email"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "id": id
    };
}