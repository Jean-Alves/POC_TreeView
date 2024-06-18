class AssetEntity {
  String id;
  String? locationId;
  String name;
  String? parentId;
  String? sensorType;
  String? status;
  String? gatewayId;
  String? sensorId;
  List<AssetEntity> subAssetList;
  bool expanded;

  AssetEntity({
    required this.id,
    this.locationId,
    required this.name,
    this.parentId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.sensorId,
    List<AssetEntity>? initialSubAssets,
    this.expanded = false,
  }) : subAssetList = List<AssetEntity>.from(initialSubAssets ?? []);
}
