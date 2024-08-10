import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class CustomShaderMask extends StatelessWidget {
  const CustomShaderMask({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          const Offset(20.0, 0.0),
          const Offset(20.0, 50.0),
          [
            MyColors.primaryFont,
            MyColors.primary,
          ],
        );
      },
      child: child,
    );
  }
}
