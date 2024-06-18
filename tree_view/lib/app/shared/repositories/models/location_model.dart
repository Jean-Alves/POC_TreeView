class LocationModel {
  String id;
  String name;
  String? parentId; // Usando String? para permitir valores nulos

  LocationModel({
    required this.id,
    required this.name,
    this.parentId, // Não é necessário ser required, pois pode ser nulo
  });

  // Método para converter um Map (vindo de um JSON, por exemplo) em uma instância de LocationModel
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
