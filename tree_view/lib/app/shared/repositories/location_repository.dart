import 'package:tree_view/app/shared/webapi/webclient.dart';

import '../entities/entities.dart';
import 'interfaces/interfaces.dart';
import 'models/models.dart';

class LocationRepository implements ILocationRepository {
  final WebClient _client;

  LocationRepository(this._client);

  @override
  Future<List<LocationEntity>> getLocationByCompanyId(String companyId) async {
    try {
      final response = await _client
          .get("https://fake-api.tractian.com/companies/$companyId/locations");

      final model = response.data
          .map<LocationModel>((e) => LocationModel.fromJson(e))
          .toList() as List<LocationModel>;
      return model
          .map(
            (c) => LocationEntity(
              id: c.id,
              name: c.name,
              parentId: c.parentId,
            ),
          )
          .toList();
    } catch (e) {
      // Enviar pro analitcs
      return [];
    }
  }
}
