import 'package:flutter_modular/flutter_modular.dart';
import 'package:tree_view/app/app_module.dart';
import 'package:tree_view/app/modules/asset/asset_module.dart';
import 'package:tree_view/app/modules/home/home_store.dart';

import '../../app_paths.dart';
import '../../shared/repositories/repositories.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<ICompanyRepository>(CompanyRepository.new);
    i.addSingleton(
      HomeStore.new,
    );
  }

  @override
  void routes(r) {
    r.child(
      AppPaths.initial,
      child: (context) => HomePage(),
    );
    r.module(AppPaths.assetPage, module: AssetModule());
  }
}
