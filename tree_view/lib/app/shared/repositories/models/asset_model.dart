class AssetModel {
  String id;
  String? locationId;
  String name;
  String? parentId;
  String? sensorType;
  String? status;
  String? gatewayId;
  String? sensorId;

  AssetModel({
    required this.id,
    this.locationId,
    required this.name,
    this.parentId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.sensorId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      locationId: json['locationId'],
      name: json['name'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
      sensorId: json['sensorId'],
    );
  }
}
