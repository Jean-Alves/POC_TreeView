import 'package:flutter/material.dart';
import 'package:tree_view/app/shared/core/colors/app_colors.dart';

import '../../../shared/core/core.dart';

class ButtonCompanyWidget extends StatelessWidget {
  final String name;
  final BoxConstraints constraints;
  final void Function() onTap;
  final Color? buttonColor;

  const ButtonCompanyWidget({
    super.key,
    required this.name,
    required this.constraints,
    required this.onTap,
    this.buttonColor = appColorSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: constraints.maxWidth * .9,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: buttonColor,
          ),
          child: Center(
            child: Row(
              children: [
                const SizedBox(width: 20),
                Image.asset(
                  ICON_BUTTON,
                  height: 22,
                ),
                const SizedBox(width: 20),
                Text(
                  '$name Unit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
