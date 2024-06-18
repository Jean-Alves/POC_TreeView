import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tree_view/app/shared/utils/utils.dart';

import '../../shared/shared.dart';
import 'asset_store.dart';
import 'enum/enum.dart';
import 'widgets/widgets.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final AssetStore store = Modular.get();

  final TextEditingController searchController = TextEditingController();
  FilterType? selectedFilter;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _toggleFilter(FilterType filter) {
    setState(() {
      if (selectedFilter == filter) {
        selectedFilter = null; // Desmarca se já está selecionado
      } else {
        selectedFilter = filter; // Marca o filtro selecionado
      }
    });
    store.filter(searchController.text, selectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColorPrimary,
        centerTitle: true,
        title: const Text(
          "Assets",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Modular.to.pop();
          },
          child: const SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Observer(builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchBar(),
                _buildButtonsFilter(),
                const Divider(
                  color: appColorGrey,
                ),
                _buildExpanded(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Function debouncedSearch = debounce(
    (Map<String, dynamic> args) {
      String value = args["value"] as String;
      var filter = args["filter"];
      Modular.get<AssetStore>().filter(value, filter);
    },
  );
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            onChanged: (value) {
              setState(() {});
              debouncedSearch({"value": value, "filter": selectedFilter});
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: appColorGrey,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        // Limpa o texto ao tocar no ícone
                        setState(
                          () {
                            searchController.clear();
                          },
                        );
                      },
                    ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: "Buscar Ativo ou Local",
              hintStyle: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsFilter() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          FilterButtonWidget(
            buttonText: "Sensor Energia",
            icon: Icons.bolt,
            onTap: () => _toggleFilter(FilterType.energy),
            isSelected: selectedFilter == FilterType.energy,
          ),
          const SizedBox(width: 10),
          FilterButtonWidget(
            buttonText: "Crítico",
            icon: Icons.error_outline,
            onTap: () => _toggleFilter(FilterType.alert),
            isSelected: selectedFilter == FilterType.alert,
          ),
        ],
      ),
    );
  }

  Widget _buildExpanded() {
    if (store.locationsOrigin.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (store.listLocations.isEmpty) {
      return const Center(
        child: Text('Filtro não encontrado'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: store.listLocations.length,
      itemBuilder: (context, index) {
        final location = store.listLocations[index];

        if (location.subLocations.isNotEmpty ||
            location.assetsList.isNotEmpty) {
          return CustomLocalExpansionWidget(
            location: location,
          );
        }

        return CustomListTile(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          name: location.name,
        );
      },
    );
  }
}
