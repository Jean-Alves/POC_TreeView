import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  final EdgeInsets padding;
  final Widget? iconComponent;
  final bool isAsset;
  const CustomListTile({
    super.key,
    required this.padding,
    required this.name,
    this.iconComponent,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: padding,
      title: Row(
        children: [
          iconComponent != null ? _buildIconComponent() : _buildNoIcon()
        ],
      ),
    );
  }

  Widget _buildNoIcon() {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Image.asset(
            isAsset ? "assets/images/asset.png" : "assets/images/location.png",
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildIconComponent() {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Image.asset(
            "assets/images/component.png",
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 10),
        iconComponent!,
      ],
    );
  }
}
