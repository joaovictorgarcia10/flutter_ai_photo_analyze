import 'package:flutter/material.dart';
import 'package:flutter_ai_photo_analyze/widgets/loading/loading_component.dart';

class ButtonComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isDisabled;

  const ButtonComponent({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24.0),
      onTap: (isLoading || isDisabled) ? null : onTap,
      child: Container(
        height: 48.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: (isLoading || isDisabled) ? Colors.grey : Colors.purple[900],
        ),
        child: isLoading
            ? const LoadingComponent()
            : Center(
                child: Text(title),
              ),
      ),
    );
  }
}
