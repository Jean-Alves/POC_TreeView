import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class FilterButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final IconData icon;
  final bool isSelected;

  const FilterButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          color: isSelected ? appColorSecondary : Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: .7,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
