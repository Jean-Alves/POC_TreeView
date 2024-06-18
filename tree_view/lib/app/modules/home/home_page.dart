import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../app_paths.dart';
import '../../shared/core/colors/colors.dart';
import '../../shared/core/settings/settings.dart';
import '../../shared/entities/company_entity.dart';
import 'home_store.dart';
import 'widgets/button_company_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeStore store = Modular.get();

  List<CompanyEntity> get companies => store.companies;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: appColorPrimary,
            centerTitle: true,
            title: Image.asset(
              HEADER_HOME,
              height: 30,
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Observer(builder: (_) {
                return Column(
                  children: [
                    const SizedBox(height: 40),
                    store.companies.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ButtonCompanyWidget(
                                  name: companies[index].name,
                                  constraints: constraints,
                                  onTap: () {
                                    Modular.to.pushNamed(
                                      AppPaths.assetPage,
                                      arguments: companies[index].id,
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 30);
                              },
                              itemCount: store.companies.length,
                            ),
                          )
                        : const Column(
                            children: [
                              SizedBox(height: 100),
                              CircularProgressIndicator(
                                color: appColorPrimary,
                              ),
                            ],
                          ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
