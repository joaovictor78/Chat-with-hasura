import 'package:mobx/mobx.dart';

import 'shared/models/user_model.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
UserModel userController;
}
