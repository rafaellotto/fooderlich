import 'package:flutter/material.dart';
import 'package:fooderlich/navigation/app_link.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    final link = AppLink.fromLocation(routeInformation.location);

    return link;
  }

  @override
  RouteInformation restoreRouteInformation(AppLink configuration) {
    return RouteInformation(
      location: configuration.toLocation(),
    );
  }
}
