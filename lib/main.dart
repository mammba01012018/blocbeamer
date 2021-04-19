import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'beam_locations.dart';
import 'member_bloc/member_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MemberBloc>(
      create: (context) => MemberBloc(),
    ),
  ], child: new MyApp()));
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerRouterDelegate(
    locationBuilder: (state) {
      if (state.pathBlueprintSegments.contains('account-details-page')) {
        return AccountDetailsPageLocation(state);
      }
      if (state.pathBlueprintSegments.contains('update-member-page')) {
        return UpdateMemberPageLocation(state);
      }
      return HomeLocation(state);
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerRouteInformationParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}
