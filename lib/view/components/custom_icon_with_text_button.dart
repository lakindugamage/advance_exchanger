import 'package:advance_exchanger/view/common/color/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomIconWithTextButton extends StatelessWidget {
  final double? width;
  final double height;
  final Color iconColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? bgColor;
  final Gradient? bgGradient;
  final double borderRadius;
  final VoidCallback onTap;
  final bool isActive;
  final IconData icon;

  const CustomIconWithTextButton({
    super.key,
    this.width,
    this.height = 56,
    this.bgColor = CustomColor.ash,
    this.iconColor = CustomColor.white,
    this.bgGradient,
    this.borderRadius = 27,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w500,
    this.isActive = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? deviceWidth,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: bgGradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
