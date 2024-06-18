import 'package:mobx/mobx.dart';

import '../../shared/shared.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  ICompanyRepository companyRepository;

  HomeStoreBase(this.companyRepository) {
    getCompanies();
  }

  @observable
  ObservableList<CompanyEntity> companies = ObservableList<CompanyEntity>();

  @action
  Future<void> getCompanies() async {
    companies = ObservableList<CompanyEntity>();
    companies.addAll(await companyRepository.getCompanies());
  }
}
