import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'bloc.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {

  MemberBloc() : super(InitialMemberState());
  
  @override
  MemberState get initialState => InitialMemberState();

  @override
  Stream<MemberState> mapEventToState(MemberEvent event) async* {
    try {
      if (event is UpdateMember) {
        yield LoadingMemberState();
        await Future.delayed(Duration(milliseconds: 200));

        final _storage = FlutterSecureStorage();
        _storage.write(key: 'member', value: json.encode(event.member));
        
        yield UpdatedMemberState(member: event.member);
      }
    } catch(e) {
      print(e.toString());
    }
  }
  
}
