import 'package:flutter/material.dart';

class OptionLabelWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const OptionLabelWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10.0),
                Text(title),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10.0)
        ],
      ),
    );
  }
}
