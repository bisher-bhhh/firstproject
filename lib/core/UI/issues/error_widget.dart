import 'package:bisherproject/core/logical/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'package:styled_widget/styled_widget.dart';

import '../styles/styles.dart';
import '../widgets/custom_widgets/custom_widgets.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(this.message, this.onRefresh, {super.key});
  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextTr(
          message,
          align: TextAlign.center,
          style: titleStyle(),
        ),
        20.hSpace,
        InkWell(
          onTap: onRefresh,
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
