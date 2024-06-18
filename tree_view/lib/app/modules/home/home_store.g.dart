// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$companiesAtom =
      Atom(name: 'HomeStoreBase.companies', context: context);

  @override
  ObservableList<CompanyEntity> get companies {
    _$companiesAtom.reportRead();
    return super.companies;
  }

  @override
  set companies(ObservableList<CompanyEntity> value) {
    _$companiesAtom.reportWrite(value, super.companies, () {
      super.companies = value;
    });
  }

  late final _$getCompaniesAsyncAction =
      AsyncAction('HomeStoreBase.getCompanies', context: context);

  @override
  Future<void> getCompanies() {
    return _$getCompaniesAsyncAction.run(() => super.getCompanies());
  }

  @override
  String toString() {
    return '''
companies: ${companies}
    ''';
  }
}
