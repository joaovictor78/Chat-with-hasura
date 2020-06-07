import 'package:bestar_hasura/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:bestar_hasura/app/app_widget.dart';
import 'package:bestar_hasura/app/modules/home/home_module.dart';
import 'shared/repositories/chat_repository.dart';
import 'package:hasura_connect/hasura_connect.dart';
class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => ChatRepository(i.get<HasuraConnect>())),
        Bind((i) => HasuraConnect('https://bestar-chat.herokuapp.com/v1/graphql'))
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
