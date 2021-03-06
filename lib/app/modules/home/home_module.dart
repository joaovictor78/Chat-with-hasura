import 'package:bestar_hasura/app/modules/home/home_controller.dart';
import 'package:bestar_hasura/app/shared/repositories/chat_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bestar_hasura/app/modules/home/home_page.dart';

import '../../app_controller.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get<ChatRepository>(), i.get<AppController>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
