import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:flutter/material.dart';

class IconedCircularButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final String label;

  IconedCircularButton({
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        this.label,
        style: TextStyle(
          fontFamily: FontUtils.POPPINS,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
    );
  }
}
