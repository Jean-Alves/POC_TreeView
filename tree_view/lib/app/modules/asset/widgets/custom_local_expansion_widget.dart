import 'package:flutter/material.dart';
import 'package:tree_view/app/modules/asset/widgets/custom_asset_expansion_widget.dart';

import '../../../shared/shared.dart';
import 'custom_listtile_widget.dart';

class CustomLocalExpansionWidget extends StatefulWidget {
  final LocationEntity location;
  final double leftPadding;

  const CustomLocalExpansionWidget({
    super.key,
    required this.location,
    this.leftPadding = 16,
  });

  @override
  State<CustomLocalExpansionWidget> createState() =>
      _CustomLocalExpansionWidgetState();
}

class _CustomLocalExpansionWidgetState
    extends State<CustomLocalExpansionWidget> {
  LocationEntity get location => widget.location;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        leading: Icon(
          widget.location.expanded
              ? Icons.keyboard_arrow_down
              : Icons.arrow_forward_ios,
          size: location.expanded ? 20 : 12,
        ),
        trailing: const SizedBox.shrink(),
        tilePadding: EdgeInsets.only(left: widget.leftPadding),
        title: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                ICON_LOCATION,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        onExpansionChanged: (bool expanded) {
          location.expanded = expanded;
          setState(() {});
        },
        children: [
          ...location.subLocations.map(
            (subLocation) {
              if (subLocation.subLocations.isNotEmpty) {
                return CustomLocalExpansionWidget(
                  location: subLocation,
                  leftPadding: widget.leftPadding + 16,
                );
              }
              if (subLocation.assetsList.isNotEmpty) {
                return Column(
                  children: subLocation.assetsList
                      .map(
                        (e) => CustomAssetExpansionWidget(
                          asset: e,
                          leftPadding: widget.leftPadding + 16,
                        ),
                      )
                      .toList(),
                );
              }
              return CustomListTile(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                name: subLocation.name,
              );
            },
          ),
          ...location.assetsList.map(
            (asset) {
              if (asset.subAssetList.isNotEmpty) {
                return Column(
                  children: asset.subAssetList
                      .map(
                        (e) => CustomAssetExpansionWidget(
                          asset: e,
                          leftPadding: widget.leftPadding * 4,
                        ),
                      )
                      .toList(),
                );
              }
              return CustomListTile(
                padding: EdgeInsets.only(
                    left: widget.leftPadding * 4, top: 8.0, bottom: 8.0),
                name: asset.name,
                isAsset: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
