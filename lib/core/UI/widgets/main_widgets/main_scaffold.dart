import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../styles/styles.dart';
import '../custom_widgets/custom_back_button.dart';
import '../custom_widgets/custom_widgets.dart';
import 'package:styled_widget/styled_widget.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    super.key,
    required this.child,
    this.title,
    this.titleArgs,
    this.selectedId = '',
    this.appbarColor,
    this.extendBehindAppbar = false,
    this.itemsColor,
    this.fab,
    this.avoidBottomInset = true,
    this.actions,
    this.drawerDragEdge = 200,
    this.leadingWidget,
    this.onLeadingPressed,
    this.withAppbar = true,
    this.hideLeading = false,
    this.withBottomBar = false,
    this.onButtonBarTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.appBar,
  });
  final Function(int)? onButtonBarTap;
  final bool hideLeading, withBottomBar;
  final bool withAppbar;
  final double drawerDragEdge;
  final List<String>? titleArgs;
  final List<Widget>? actions;
  final bool extendBehindAppbar, avoidBottomInset;
  final String? title;
  final Widget? leadingWidget;
  final VoidCallback? onLeadingPressed;
  final Widget child;
  final FloatingActionButton? fab;
  final Color? itemsColor, appbarColor;
  final String selectedId;
  final EdgeInsets? padding;
  final PreferredSizeWidget? appBar;
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawerEdgeDragWidth: widget.drawerDragEdge,
      resizeToAvoidBottomInset: widget.avoidBottomInset,
      extendBodyBehindAppBar: widget.extendBehindAppbar,
      floatingActionButton: widget.fab,
      appBar: (widget.withAppbar)
          ? (widget.appBar == null)
              ? CustomAppbar(
                  label: widget.title,
                  actions: widget.actions,
                  onLeadingPressed: widget.onLeadingPressed,
                  hideLeading: widget.hideLeading,
                )
              : widget.appBar
          : null,
      body: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: widget.child,
      ).safeArea(),
    );
  }
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.itemsColor,
    required this.label,
    this.actions,
    this.onLeadingPressed,
    required this.hideLeading,
  });
  final VoidCallback? onLeadingPressed;
  final bool hideLeading;
  final List<Widget>? actions;
  final String? label;
  final Color? itemsColor;

  @override
  Size get preferredSize => const Size.fromHeight(40);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: !hideLeading,
        child: const CustomBackButton(),
      ).padding(left: 15),
      title: TextTr(
        label ?? "",
        style: boldStyle(size: 16),
      ),
      centerTitle: true,
      forceMaterialTransparency: true,
      actions: actions,
    );
  }
}
