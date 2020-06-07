import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Observer(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: controller.messages.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(controller.messages.hasError){
                      return Center(
                        child: Text('Ocorreu um erro na conexão'),
                      );
                    }
                    if(controller.messages.data == null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListTile(
                      title: controller.messages.data[index].user.nme,
                      subtitle: Text(controller.messages.data[index].content),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(40.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Digite uma mensagem...",
                        fillColor: Colors.white70),
                    onChanged: controller.getMessage,
                  )),
                  IconButton(
                      icon: Icon(Icons.send, color: Colors.blue, size: 38),
                      onPressed: () {
                        controller.sendMessage();
                      }),
                ],
              ),
              Container(
                height: 10,
              ),
            ],
          );
        }));
  }
}
