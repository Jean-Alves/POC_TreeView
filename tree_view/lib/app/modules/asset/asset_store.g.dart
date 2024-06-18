// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetStore on AssetStoreBase, Store {
  late final _$listAssetsAtom =
      Atom(name: 'AssetStoreBase.listAssets', context: context);

  @override
  ObservableList<AssetEntity> get listAssets {
    _$listAssetsAtom.reportRead();
    return super.listAssets;
  }

  @override
  set listAssets(ObservableList<AssetEntity> value) {
    _$listAssetsAtom.reportWrite(value, super.listAssets, () {
      super.listAssets = value;
    });
  }

  late final _$listLocationsAtom =
      Atom(name: 'AssetStoreBase.listLocations', context: context);

  @override
  ObservableList<LocationEntity> get listLocations {
    _$listLocationsAtom.reportRead();
    return super.listLocations;
  }

  @override
  set listLocations(ObservableList<LocationEntity> value) {
    _$listLocationsAtom.reportWrite(value, super.listLocations, () {
      super.listLocations = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('AssetStoreBase.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
listAssets: ${listAssets},
listLocations: ${listLocations}
    ''';
  }
}
