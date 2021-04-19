import 'package:blocbeamer/models/member.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MemberEvent {}

class UpdateMember extends MemberEvent {
  final Member member;

  UpdateMember({required this.member});
}
