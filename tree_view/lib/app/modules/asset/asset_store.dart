import 'package:mobx/mobx.dart';
import 'package:tree_view/app/modules/asset/enum/filter_type.dart';

import '../../shared/shared.dart';

part 'asset_store.g.dart';

class AssetStore = AssetStoreBase with _$AssetStore;

abstract class AssetStoreBase with Store {
  final String companyId;
  final IAssetRepository _assetRepository;
  final ILocationRepository _locationRepository;
  AssetStoreBase(
    this._assetRepository,
    this._locationRepository, {
    required this.companyId,
  }) {
    load();
  }
  @observable
  ObservableList<LocationEntity> locationsOrigin =
      ObservableList<LocationEntity>();

  @observable
  ObservableList<AssetEntity> listAssets = ObservableList<AssetEntity>();

  @observable
  ObservableList<LocationEntity> listLocations =
      ObservableList<LocationEntity>();

  @action
  Future<void> load() async {
    final [
      assets as List<AssetEntity>,
      locations as List<LocationEntity>,
    ] = await Future.wait(
      [
        _assetRepository.getAssetsByCompanyId(companyId),
        _locationRepository.getLocationByCompanyId(companyId),
      ],
    );
    listAssets = ObservableList<AssetEntity>();
    listLocations = ObservableList<LocationEntity>();

    locationsOrigin.addAll(
      mergeAssetWithLocation(
        orderLocation(locations),
        orderAssets(assets),
      ),
    );
    listLocations.addAll(locationsOrigin);
  }

  List<LocationEntity> orderLocation(List<LocationEntity> locations) {
    try {
      List<LocationEntity> listLocal =
          locations.where((local) => local.parentId == null).toList();

      // Para cada local principal, encontrar e adicionar seus sublocais
      for (var localPrincipal in listLocal) {
        for (var possibleSubLocal in locations) {
          if (possibleSubLocal.parentId == localPrincipal.id) {
            // Se for um sublocal, adicione à lista de sublocais do local principal
            localPrincipal.subLocations.add(possibleSubLocal);
          }
        }
      }

      return listLocal;
    } catch (_) {
      return [];
      // Tratamento de erro, se necessário
    }
  }

  List<AssetEntity> orderAssets(List<AssetEntity> lAssets) {
    var assets = lAssets.where((asset) => asset.parentId == null).toList();

    for (var lAssets in lAssets) {
      if (lAssets.parentId != null) {
        for (var asset in assets) {
          if (lAssets.parentId == asset.id) {
            asset.subAssetList.add(lAssets);
          }
        }
      }
    }
    return assets;
  }

  List<LocationEntity> mergeAssetWithLocation(
      List<LocationEntity> locations, List<AssetEntity> assets) {
    for (var location in locations) {
      for (var asset in assets) {
        if (asset.locationId == location.id) {
          location.assetsList.add(asset);
        }
      }
      mergeAssetWithLocation(location.subLocations, assets);
    }

    return locations;
  }

  void filter(String text, FilterType? type) {
    if (text.isEmpty && type == null) {
      listLocations = ObservableList<LocationEntity>();
      listLocations.addAll(locationsOrigin);
      return;
    }
    listLocations = ObservableList<LocationEntity>();
    listLocations.addAll(_filterLocation(locationsOrigin, text, type));
  }

  List<LocationEntity> _filterLocation(
      List<LocationEntity> lLocations, String text, FilterType? type) {
    List<LocationEntity> fLocations = [];
    try {
      for (var location in lLocations) {
        final bool existText = text.isNotEmpty &&
            location.name.toLowerCase().contains(text.toLowerCase());

        final filterAssets = _filterAsset(location.assetsList, text, type);

        final filterSublocation =
            _filterLocation(location.subLocations, text, type);

        if (existText ||
            filterAssets.isNotEmpty ||
            filterSublocation.isNotEmpty) {
          location = LocationEntity(
            id: location.id,
            name: location.name,
            parentId: location.parentId,
            initialSubLocations: filterSublocation,
            initialAssetsList: filterAssets,
          );
          fLocations.add(location);
        }
      }
    } catch (_) {}
    return fLocations;
  }

  List<AssetEntity> _filterAsset(
      List<AssetEntity> assetList, String text, FilterType? type) {
    List<AssetEntity> fList = [];

    for (var asset in assetList) {
      final bool existText = text.isNotEmpty &&
          asset.name.toLowerCase().contains(text.toLowerCase());

      final matchFilterType = asset.sensorType == type?.name;

      final subAssetList = _filterAsset(asset.subAssetList, text, type);

      if (existText || matchFilterType || subAssetList.isNotEmpty) {
        asset = AssetEntity(
          id: asset.id,
          name: asset.name,
          locationId: asset.locationId,
          initialSubAssets: subAssetList,
          parentId: asset.parentId,
          sensorType: asset.sensorType,
          status: asset.status,
        );
        fList.add(asset);
      }
    }
    return fList;
  }
}
