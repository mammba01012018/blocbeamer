import 'package:beamer/beamer.dart';
import 'package:blocbeamer/pages/home.dart';
import 'package:flutter/widgets.dart';

import 'pages/account_details_page.dart';
import 'pages/update_member_page.dart';

class HomeLocation extends BeamLocation {
  HomeLocation(BeamState state) : super(state);

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('home'),
          child: Home(),
        ),
      ];

  @override
  List<String> get pathBlueprints => ['/'];
}

class AccountDetailsPageLocation extends BeamLocation {
  AccountDetailsPageLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/account-details-page/update'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        ...HomeLocation(state).pagesBuilder(context, state),
        if (state.uri.pathSegments.contains('account-details-page'))
          BeamPage(
            key: ValueKey('account-details-page'),
            child: AccountDetailsPage(),
          ),
        if (state.uri.pathSegments.contains('update'))
          BeamPage(
            key: ValueKey('update-member-page'),
            child: UpdateMemberPage(),
          ),
      ];
}
