import 'package:tree_view/app/shared/webapi/webclient.dart';

import '../entities/entities.dart';
import 'interfaces/interfaces.dart';
import 'models/models.dart';

class AssetRepository implements IAssetRepository {
  final WebClient _client;

  AssetRepository(this._client);

  @override
  Future<List<AssetEntity>> getAssetsByCompanyId(String companyId) async {
    try {
      final response = await _client
          .get("https://fake-api.tractian.com/companies/$companyId/assets");

      final model = response.data
          .map<AssetModel>((e) => AssetModel.fromJson(e))
          .toList() as List<AssetModel>;
      return model
          .map(
            (c) => AssetEntity(
              id: c.id,
              name: c.name,
              gatewayId: c.gatewayId,
              locationId: c.locationId,
              parentId: c.parentId,
              sensorId: c.sensorId,
              sensorType: c.sensorType,
              status: c.status,
            ),
          )
          .toList();
    } catch (e) {
      // Enviar pro analitcs
      return [];
    }
  }
}
