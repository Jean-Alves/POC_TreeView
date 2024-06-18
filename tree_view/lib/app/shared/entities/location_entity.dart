import 'package:tree_view/app/shared/shared.dart';

class LocationEntity {
  String id;
  String name;
  String? parentId;
  List<LocationEntity> subLocations;
  List<AssetEntity> assetsList;
  bool expanded;

  LocationEntity({
    required this.id,
    required this.name,
    this.parentId,
    List<LocationEntity>? initialSubLocations,
    List<AssetEntity>? initialAssetsList = const [],
    this.expanded = false,
  })  : subLocations = List<LocationEntity>.from(initialSubLocations ?? []),
        assetsList = List<AssetEntity>.from(initialAssetsList ?? []);

  @override
  String toString() {
    return 'LocationEntity(id: $id, name: $name, parentId: $parentId, subLocations: $subLocations, assetsList: $assetsList, expanded: $expanded)';
  }
}
