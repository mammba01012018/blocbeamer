import 'package:blocbeamer/models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../member_bloc/member_bloc.dart';
import '../member_bloc/member_state.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  late Member _member;

  @override
  Widget build(BuildContext context) {
    this._member = Member.fromJson(context.currentBeamLocation.state.data);

    return Scaffold(
        appBar: AppBar(
            title: Text('Account Details'), backgroundColor: Colors.teal),
        body: BlocConsumer<MemberBloc, MemberState>(
            listener: (context, state) async {
          if (state is UpdatedMemberState) {
            this.setState(() {
              _member = state.member;
            });
          }
        }, builder: (context, state) {
          return userCard();
        }));
  }

  Widget userCard() {
    var name = _member.firstName + ' ' + _member.lastName;

    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Center(
          child: Card(
              elevation: 2.5,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 50.0,
                        backgroundImage: new NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIAVvRR35IC9yiDnGjU5dJJU_wxJLLiXQKpefCQdtoUSF7PCQRTg")),
                    const SizedBox(height: 30.0),
                    Text(
                      name,
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                    const SizedBox(height: 30.0),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.teal,
                            padding: EdgeInsets.all(10.0),
                            child: new Text(
                              'Update Member',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                            onPressed: () {
                              Beamer.of(context).beamToNamed(
                                'account-details-page/update',
                                data: _member.toJson(),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              )),
        )));
  }
}
