import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MaterialInk extends StatelessWidget {
  const MaterialInk({
    super.key,
    this.onTap,
    required this.child,
    this.borderRadius,
    this.childPadding,
    this.color,
  });
  final Color? color;
  final VoidCallback? onTap;
  final double? childPadding;
  final Widget child;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: InkWell(
        splashColor: color,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child.padding(all: childPadding),
      ),
    );
  }
}
