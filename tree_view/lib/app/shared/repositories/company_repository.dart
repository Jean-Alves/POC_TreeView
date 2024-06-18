import 'package:tree_view/app/shared/webapi/webclient.dart';

import '../entities/entities.dart';
import 'interfaces/interfaces.dart';
import 'models/models.dart';

class CompanyRepository implements ICompanyRepository {
  final WebClient _client;

  CompanyRepository(this._client);

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    try {
      final response =
          await _client.get("https://fake-api.tractian.com/companies");

      final model = response.data
          .map<CompanyModel>((e) => CompanyModel.fromJson(e))
          .toList() as List<CompanyModel>;
      return model
          .map(
            (c) => CompanyEntity(
              id: c.id,
              name: c.name,
            ),
          )
          .toList();
    } catch (e) {
      // enviar pro analitcs
      return [];
    }
  }
}
