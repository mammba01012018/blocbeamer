import 'dart:convert';

import 'package:blocbeamer/member_bloc/bloc.dart';
import 'package:blocbeamer/models/member.dart';
import 'package:blocbeamer/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Member? _member;

  final _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    setInitialMember();
  }

  setInitialMember() async {
    final _storage = FlutterSecureStorage();
    String? memberString = await _storage.read(key: 'member');
    if (memberString != null) {
      Map<String, dynamic> map = json.decode(memberString);
      this.setState(() {
        _member = Member.fromJson(map);
      });
    } else {
      this.setState(() {
        _member = new Member(firstName: 'Levi', lastName: 'Ackerman');
        _storage.write(key: 'member', value: json.encode(_member));
      });
    }

    print(_member);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Member'),
        ),
        drawer: HomeDrawer(),
        body: Container(
            child: BlocConsumer<MemberBloc, MemberState>(
                listener: (context, state) async {
          if (state is UpdatedMemberState) {
            this.setState(() {
              _member = state.member;
            });
          }
        }, builder: (context, state) {
          return Center(
              child: _member != null
                  ? Text(
                      'Current name: ' +
                          _member!.firstName +
                          ' ' +
                          _member!.lastName,
                      style: TextStyle(fontSize: 30))
                  : Text(''));
        })));
  }
}
