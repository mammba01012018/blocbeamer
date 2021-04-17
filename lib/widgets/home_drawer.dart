import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:blocbeamer/member_bloc/member_bloc.dart';
import 'package:blocbeamer/member_bloc/member_state.dart';
import 'package:blocbeamer/models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  Member? _member;

  @override
  void initState() {
    super.initState();
    setInitialMember();
  }

  setInitialMember() async {
    final _storage = FlutterSecureStorage();
    String? memberString = await _storage.read(key: 'member');
    Map<String, dynamic> map = json.decode(memberString!);
    this.setState(() {
       _member = Member.fromJson(map);
    });
    print(_member);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(        
      child:  BlocConsumer <MemberBloc, MemberState> (
        listener: (context, state) async {
          if(state is UpdatedMemberState) {
            this.setState(() {
              _member = state.member;
            });
          }
        },
        builder: (context, state) {
          return  ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                margin: const EdgeInsets.only(bottom: 0.0, top: 0.0),
                accountName: _member != null ? Text(_member!.firstName + ' '+ _member!.lastName) : Text(''),
                accountEmail: new Text('@gmail.com'),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIAVvRR35IC9yiDnGjU5dJJU_wxJLLiXQKpefCQdtoUSF7PCQRTg") 
                  ),
                ),
              ),
              ListTile(
                title: new Text('Account Details Page'),
                onTap: () async {
                    Beamer.of(context).beamToNamed('/account-details-page', data: _member!.toJson(), stacked: true);
                }
              ),
            ],
          );
        }
      ),
    );  
  }
}