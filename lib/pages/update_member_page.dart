import 'package:blocbeamer/member_bloc/bloc.dart';
import 'package:blocbeamer/member_bloc/member_bloc.dart';
import 'package:blocbeamer/member_bloc/member_event.dart';
import 'package:blocbeamer/models/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMemberPage extends StatefulWidget {
  @override
  _UpdateMemberPageState createState() => _UpdateMemberPageState();
}

class _UpdateMemberPageState extends State<UpdateMemberPage> {
  late Member _member;
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;

  @override
  Widget build(BuildContext context) {
    this._member = Member.fromJson(context.currentBeamLocation.state.data);

    return Scaffold(
        appBar: AppBar(
          title: Text('Update Member Page'),
        ),
        body: BlocConsumer<MemberBloc, MemberState>(
            listener: (context, state) async {
          if (state is UpdatedMemberState) {
            Beamer.of(context).beamBack();
          }
        }, builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                TextFormField(
                  onSaved: (String? value) {
                    firstName = value;
                  },
                  initialValue: _member.firstName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'FirstName',
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  onSaved: (String? value) {
                    lastName = value;
                  },
                  initialValue: _member.lastName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'LastName',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Member updatedMember = new Member(
                          firstName: firstName ?? '', lastName: lastName ?? '');
                      BlocProvider.of<MemberBloc>(context).add(
                        UpdateMember(member: updatedMember),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          );
        }));
  }
}
