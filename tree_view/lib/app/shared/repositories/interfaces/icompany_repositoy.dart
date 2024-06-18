import '../../entities/entities.dart';

abstract class ICompanyRepository {
  Future<List<CompanyEntity>> getCompanies();
}
