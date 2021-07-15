import "package:flutter/material.dart";

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigatePage(Widget widget) {
    return navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  Future<dynamic> navigateToAndRemoveUntill(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<dynamic> navigateAndRemoveUntill(Widget widget) {
    return navigatorKey.currentState.pushAndRemoveUntil(
        (MaterialPageRoute(builder: (context) => widget)), (route) => false);
  }

  void pop() {
    return navigatorKey.currentState.pop();
  }
}
