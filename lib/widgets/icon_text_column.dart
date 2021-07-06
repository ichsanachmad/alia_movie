import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:flutter/material.dart';

class IconTextColumn extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onPress;

  IconTextColumn({
    required this.icon,
    required this.label,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          this.icon,
          SizedBox(height: 4),
          Text(
            this.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontUtils.POPPINS,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
