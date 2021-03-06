import 'package:ars_dialog/src/transition.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  final bool? dismissable;
  final Widget child;
  final DialogTransitionType? dialogTransitionType;
  final Color? barrierColor;
  final RouteSettings? routeSettings;
  final bool? useRootNavigator;
  final bool? useSafeArea;
  final Duration? transitionDuration;

  DialogUtils({
    required this.child,
    this.useSafeArea,
    this.barrierColor,
    this.dismissable,
    this.dialogTransitionType,
    this.routeSettings,
    this.transitionDuration,
    this.useRootNavigator,
  });

  ///Show dialog directly
  Future show<T>(BuildContext context) => showGeneralDialog<T>(
        context: context,
        routeSettings: routeSettings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            (useSafeArea ?? true) ? SafeArea(child: child) : child,
        barrierColor: barrierColor ?? Color(0x00ffffff),
        barrierDismissible: dismissable ?? true,
        barrierLabel: "",
        transitionDuration: transitionDuration ?? Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            _animationWidget(animation, child),
        useRootNavigator: useRootNavigator ?? false,
      );

  Widget _animationWidget(Animation<double> animation, Widget child) {
    switch (dialogTransitionType ?? DialogTransitionType.NONE) {
      case DialogTransitionType.Bubble:
        return DialogTransition.bubble(animation, child);
      case DialogTransitionType.LeftToRight:
        return DialogTransition.transitionFromLeft(animation, child);
      case DialogTransitionType.RightToLeft:
        return DialogTransition.transitionFromRight(animation, child);
      case DialogTransitionType.TopToBottom:
        return DialogTransition.transitionFromTop(animation, child);
      case DialogTransitionType.BottomToTop:
        return DialogTransition.transitionFromBottom(animation, child);
      case DialogTransitionType.Shrink:
        return DialogTransition.shrink(animation, child);
      default:
    }
    return child;
  }
}
