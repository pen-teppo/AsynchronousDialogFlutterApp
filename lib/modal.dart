import 'package:flutter/material.dart';

class ModalOverlay extends PopupRoute<void> {
  ModalOverlay({
    required WidgetBuilder builder,
    Color? barrierColor = Colors.black54,
    bool barrierDismissible = true,
    String? barrierLabel,
    bool useSafeArea = true,
    RouteSettings? settings,
  }) : assert(barrierDismissible != null),
        _builder = builder,
        _barrierColor = barrierColor,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _useSafeArea = useSafeArea,
        super(settings: settings);

  final WidgetBuilder _builder;
  final bool _useSafeArea;

  @override
  Duration get transitionDuration => Duration(milliseconds: 150);

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  Color? get barrierColor => _barrierColor;
  final Color? _barrierColor;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Widget dialog = Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: this._builder(context),
    );

    if(_useSafeArea){
      return dialog;
    }

    return dialog;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}