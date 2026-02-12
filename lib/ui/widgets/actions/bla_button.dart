import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum BlaButtonType {
  primary,
  secondary,
}

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = BlaButtonType.primary,
    this.icon,
  });

  bool get _isPrimary => type == BlaButtonType.primary;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        _isPrimary ? BlaColors.primary : BlaColors.white;

    final borderColor = BlaColors.primary;

    final textColor =
        _isPrimary ? BlaColors.white : BlaColors.primary;

    return SizedBox(
      width: double.infinity ,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: onPressed == null
              ? BlaColors.disabled
              : backgroundColor,
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.symmetric(
            vertical: BlaSpacings.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(BlaSpacings.radius),
          ),
        ),
        child: _buildContent(textColor),
      ),
    );
  }
  
  // if we have icon it display if not display only text
  Widget _buildContent(Color textColor) {
    if (icon == null) {
      return Text(
        text,
        style: BlaTextStyles.button.copyWith(
          color: textColor,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon(icon, color: textColor),
        // const SizedBox(width: BlaSpacings.s),
        // Text(
        //   text,
        //   style: BlaTextStyles.button.copyWith(
        //     color: textColor,
        //   ),
        // ),
      ],
    );
  }
}
