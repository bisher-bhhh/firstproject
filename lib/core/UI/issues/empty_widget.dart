

import 'package:bisherproject/core/logical/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../styles/styles.dart';
import '../widgets/custom_widgets/custom_widgets.dart';

class EmptyInfoWidget extends StatelessWidget {
  const EmptyInfoWidget({
    Key? key,
    this.message,
    this.topPadding,
    this.onRefresh,
  }) : super(key: key);
  final String? message;
  final double? topPadding;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextTr(
          'no_results_are_found',
          style: labelStyle(size: 22),
        ).padding(top: topPadding),
        10.hSpace,
        if (onRefresh != null)
          InkWell(
            onTap: onRefresh,
            child: const Icon(Icons.refresh),
          )
      ],
    );
  }
}
