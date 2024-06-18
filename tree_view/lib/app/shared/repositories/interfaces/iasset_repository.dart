import '../../entities/entities.dart';

abstract class IAssetRepository {
  Future<List<AssetEntity>> getAssetsByCompanyId(String companyId);
}
