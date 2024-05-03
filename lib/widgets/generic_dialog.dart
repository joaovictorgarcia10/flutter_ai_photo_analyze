import 'package:flutter/material.dart';
import 'package:flutter_ai_photo_analyze/widgets/button/button_component.dart';
import 'package:flutter_ai_photo_analyze/widgets/button/second_button_component.dart';

class GenericDialog extends StatelessWidget {
  final IconData icon;
  final String content;
  final String firstButtonTitle;
  final VoidCallback onTapFirstButton;
  final String? secondButtonTitle;
  final VoidCallback? onTapSecondButton;

  const GenericDialog({
    super.key,
    required this.icon,
    required this.content,
    required this.firstButtonTitle,
    required this.onTapFirstButton,
    this.secondButtonTitle,
    this.onTapSecondButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      insetAnimationCurve: Curves.linear,
      insetAnimationDuration: const Duration(milliseconds: 2400),
      insetPadding: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Icon(
              icon,
              size: 48.0,
              color: Colors.black,
            ),
            const SizedBox(height: 16.0),
            Text(
              content,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            ButtonComponent(
              title: firstButtonTitle,
              onTap: onTapFirstButton,
            ),
            const SizedBox(height: 16.0),
            if (secondButtonTitle != null && onTapSecondButton != null)
              SecondButtonComponent(
                title: secondButtonTitle!,
                onTap: onTapSecondButton!,
              ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
