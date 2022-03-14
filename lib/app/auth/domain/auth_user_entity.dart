import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? displayName;

  AuthUserEntity({
    required this.uid,
    required this.email,
    required this.displayName
  });

  @override
  List<Object?> get props => [
    'uid',
    'email',
    'displayName'
  ];
}