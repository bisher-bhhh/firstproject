import 'package:bisherproject/core/UI/widgets/material_ink.dart';
import 'package:bisherproject/core/logical/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:styled_widget/styled_widget.dart';
import '../../../logical/utils/funcs.dart';
import '../../styles/colors.dart';
import '../custom_widgets/custom_widgets.dart';

class BarPageButton extends StatelessWidget {
  const BarPageButton({
    super.key,
    required this.asset,
    required this.label,
    required this.onTap,
  });
  final String asset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialInk(
      onTap: onTap,
      borderRadius: 10.radius,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: 10.radius,
          gradient: getTrasparenGradient(),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              asset,
              height: 33,
              color: MyColors.black,
            ),
            10.hSpace,
            TextTr(
              label,
              size: 10,
            ).fittedBox(fit: BoxFit.scaleDown),
          ],
        ),
      ),
    ).expanded();
  }
}
