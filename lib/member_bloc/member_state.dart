import 'package:blocbeamer/models/member.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MemberState {}

class InitialMemberState extends MemberState {}

class LoadingMemberState extends MemberState {}

class UpdatedMemberState extends MemberState {
  final Member member;

  UpdatedMemberState({required this.member});
}

class NotificationFlushBarState extends MemberState {
  final String message;
  final String? type;

  NotificationFlushBarState({required this.message, this.type});
}