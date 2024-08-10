import 'package:bisherproject/core/logical/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logical/utils/funcs.dart';
import '../../issues/empty_widget.dart';
import '../../issues/error_widget.dart';
import '../loading_widget.dart';
import 'template_list.dart';
import 'package:styled_widget/styled_widget.dart';


class CubitListListener<B extends StateStreamable<S>, S, M> extends StatefulWidget {
  const CubitListListener({
    super.key,
    required this.itemBuilder,
    required this.onCall,
    this.initData,
    this.padding,
    this.paddingValue,
    this.topPadding,
    this.separatorWidget,
    this.emptyWidget,
    this.withPagination = true,
  });
  final Widget Function(M) itemBuilder;
  final Widget? separatorWidget, emptyWidget;
  final bool withPagination;

  /// this function is called when fetching data at initial
  /// and at refresh, error with second param to true to reset data
  final void Function(B, bool) onCall;
  final double? topPadding;

  /// this function is called just once at initialization
  final void Function(B)? initData;
  final double? paddingValue;
  final EdgeInsets? padding;

  @override
  State<CubitListListener<B, S, M>> createState() => _CubitListListenerState<B, S, M>();
}

class _CubitListListenerState<B extends StateStreamable<S>, S, M> extends State<CubitListListener<B, S, M>> {
  late final ScrollController _scrollController;
  late final B cubit;
  @override
  void initState() {
    _scrollController = ScrollController();
    cubit = context.read<B>();
    widget.initData?.call(cubit);
    widget.onCall(cubit, false);
    if (widget.withPagination) {
      onPaginate(
        _scrollController,
        () => widget.onCall(cubit, false),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.onCall(cubit, true),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<B, S>(
          listener: (_, dynamic state) => state.maybeWhen(
            orElse: () {},
          ),
          builder: (_, dynamic state) => state.maybeWhen(
            loaded: (List<dynamic> data, bool isLoading) {
              return Column(
                children: [
                  CustomListView(
                    itemBuilder: (i) => widget.itemBuilder(data[i]),
                    count: data.length,
                    padding: widget.padding,
                    paddingValue: widget.paddingValue,
                    separatorWidget: widget.separatorWidget,
                  ),
                  Visibility(
                    visible: isLoading,
                    child: const LoadingWidget().padding(bottom: 30),
                  ),
                  Visibility(
                    visible: !isLoading && data.isEmpty,
                    child: widget.emptyWidget ??
                        EmptyInfoWidget(
                          topPadding: widget.topPadding ?? 35.hPercent,
                          onRefresh: () => widget.onCall(cubit, true),
                        ),
                  ),
                ],
              );
            },
            orElse: () => const LoadingWidget().padding(top: widget.topPadding ?? 35.hPercent),
            error: (String message) => CustomErrorWidget(
              message,
              () => widget.onCall(cubit, true),
            ).padding(top: widget.topPadding ?? 35.hPercent),
          ),
        ),
      ),
    );
  }
}
