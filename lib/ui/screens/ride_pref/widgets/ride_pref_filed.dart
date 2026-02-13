import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class RidePrefField extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Widget? endWidget;

  const RidePrefField({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.endWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: BlaColors.greyLight,
                size: 22,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  text,
                  style: BlaTextStyles.body,
                ),
              ),

              if (endWidget != null) endWidget!,
            ],
          ),
        ),
      ),
    );
  }
}
