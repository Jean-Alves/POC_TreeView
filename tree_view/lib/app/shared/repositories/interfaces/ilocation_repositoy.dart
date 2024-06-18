import '../../entities/entities.dart';

abstract class ILocationRepository {
  Future<List<LocationEntity>> getLocationByCompanyId(String companyId);
}
