import 'package:beamer/beamer.dart';
import 'package:blocbeamer/pages/home.dart';
import 'package:flutter/widgets.dart';

import 'pages/account_details_page.dart';
import 'pages/update_member_page.dart';

class HomeLocation extends BeamLocation {
  HomeLocation(BeamState state) : super(state);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
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
  List<String> get pathBlueprints => ['/account-details-page'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    ...HomeLocation(state).buildPages(context, state),
    if (state.uri.pathSegments.contains('account-details-page'))
      BeamPage(
        key: ValueKey('account-details-page'),
        child: AccountDetailsPage(),
      ),
  ];
}

class UpdateMemberPageLocation extends BeamLocation {

  UpdateMemberPageLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/update-member-page'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    ...HomeLocation(state).buildPages(context, state),
    if (state.uri.pathSegments.contains('update-member-page'))
      BeamPage(
        key: ValueKey('update-member-page'),
        child: UpdateMemberPage(),
      ),
  ];
}








