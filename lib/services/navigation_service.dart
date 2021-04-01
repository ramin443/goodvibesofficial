import 'package:flutter/material.dart';
import 'package:goodvibesofficial/utils/utils.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(
      {String routeName,
        String sourcePage,
        bool recordAnalytics = true,
        bool defaultEventName = false}) {
    if (recordAnalytics) {
      recordNavigationAnalytics(
          source: sourcePage,
          destination: routeName,
          pageEventName: !defaultEventName ? routeName : null);
    }

    return navigationKey.currentState.pushNamed(routeName);
  }

  pop() {
    return navigationKey.currentState.pop();
  }

  Future<dynamic> navigateToReplaceAll({String routeName}) {
    return navigationKey.currentState
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}
