import 'package:flutter_modular/flutter_modular.dart';
import 'package:tree_view/app/app_module.dart';
import 'package:tree_view/app/shared/repositories/asset_repository.dart';
import 'package:tree_view/app/shared/repositories/location_repository.dart';

import '../../app_paths.dart';
import '../../shared/shared.dart';
import 'asset_page.dart';
import 'asset_store.dart';

class AssetModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<IAssetRepository>(AssetRepository.new);
    i.addSingleton<ILocationRepository>(LocationRepository.new);
    i.addSingleton(
      () => AssetStore(
        i(),
        i(),
        companyId: i.args.data,
      ),
    );
  }

  @override
  void routes(r) {
    r.child(
      AppPaths.initial,
      child: (_) => const AssetPage(),
    );
  }
}
