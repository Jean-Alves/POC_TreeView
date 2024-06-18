import 'package:flutter/material.dart';
import 'package:tree_view/app/modules/asset/widgets/widgets.dart';

import '../../../shared/shared.dart';

class CustomAssetExpansionWidget extends StatefulWidget {
  final AssetEntity asset;
  final double leftPadding;

  const CustomAssetExpansionWidget({
    super.key,
    required this.asset,
    this.leftPadding = 16,
  });

  @override
  State<CustomAssetExpansionWidget> createState() =>
      _CustomAssetExpansionWidgetState();
}

class _CustomAssetExpansionWidgetState
    extends State<CustomAssetExpansionWidget> {
  AssetEntity get asset => widget.asset;
  @override
  Widget build(BuildContext context) {
    if (widget.asset.subAssetList.isEmpty) {
      return CustomListTile(
        padding: EdgeInsets.only(
            left: widget.leftPadding + 16, top: 8.0, bottom: 8.0),
        name: asset.name,
        iconComponent: _iconType(asset.sensorType ?? ""),
      );
    }
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        leading: Icon(
          widget.asset.expanded
              ? Icons.keyboard_arrow_down
              : Icons.arrow_forward_ios,
          size: asset.expanded ? 20 : 12,
        ),
        trailing: const SizedBox.shrink(),
        tilePadding: EdgeInsets.only(left: widget.leftPadding),
        title: Row(
          children: [
            SizedBox(
              height: 21,
              width: 21,
              child: Image.asset(
                ICON_ASSET,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              asset.name,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        onExpansionChanged: (bool expanded) {
          asset.expanded = expanded;
          setState(() {});
        },
        children: [
          ...asset.subAssetList.map(
            (asset) {
              if (asset.subAssetList.isNotEmpty) {
                return CustomAssetExpansionWidget(
                  asset: widget.asset,
                  leftPadding: widget.leftPadding + 16,
                );
              }

              return CustomListTile(
                padding: EdgeInsets.only(
                    left: widget.leftPadding * 3, top: 8.0, bottom: 8.0),
                name: asset.name,
                iconComponent: _iconType(asset.sensorType ?? ""),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget? _iconType(String type) {
    switch (type) {
      case "energy":
        return const Icon(
          Icons.bolt_outlined,
          color: Colors.green,
          size: 18,
        );
      case "vibration":
        return const Icon(
          Icons.vibration_outlined,
          color: Colors.green,
          size: 18,
        );
      case "alert":
        {
          return const Icon(
            Icons.warning,
            color: Colors.red,
            size: 16,
          );
        }
      default:
        return null;
    }
  }
}
