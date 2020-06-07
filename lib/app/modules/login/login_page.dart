import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: textEditingControllerName,
               decoration:
          InputDecoration(border: InputBorder.none,
          icon: Icon(Icons.person),
          hintText: 'Informe o nome'),
            onChanged: (value){
              controller.getName(value);
              textEditingControllerName.clear();
            },
          ),
          Container(
            height: 10,
          ),
          TextField(
               decoration:
          InputDecoration(border: InputBorder.none,
          icon: Icon(Icons.email),
          hintText: 'Informe o email'),
            onChanged: (value){
              controller.getEmail(value);
              textEditingControllerEmail.clear();
            },
          ),
          Container(
            height: 25,
          ),
          RaisedButton(
            child: Text('Login'),
            onPressed: () async{
             bool isLogin = await controller.login();
            if(isLogin == true){
              //vai pra home
            }
            }
          ),
        ],
      ),
    );
  }
}
