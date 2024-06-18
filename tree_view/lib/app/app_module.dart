import 'package:flutter_modular/flutter_modular.dart';

import 'app_paths.dart';
import 'modules/home/home_module.dart';
import 'shared/webapi/webapi.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton<WebClient>(WebClient.new);
  }

  @override
  void routes(r) {
    r.module(
      AppPaths.initial,
      module: HomeModule(),
    );
  }
}
