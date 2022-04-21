import 'package:equatable/equatable.dart';
import 'package:finwallet_app/common/constants/currencies.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final Currency? baseCurrency;
  final bool userConfigured;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
      required this.id,
      required this.email,
      this.name,
      this.baseCurrency,
      required this.userConfigured,
      this.createdAt,
      this.updatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'email': this.email,
      'name': this.name,
      'baseCurrency': this.baseCurrency?.code,
      'userConfigured': this.userConfigured,
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String()
    };
  }

  factory UserEntity.fromJSON(Map<String,dynamic> json) {
    return UserEntity(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        baseCurrency: json['baseCurrency'] != null ? CURRENCIES.firstWhere((element) => element.code == json['baseCurrency']) : null,
        userConfigured: json['userConfigured'],
        createdAt:  json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [
    'id',
    'email',
    'name',
    'baseCurrency',
    'userConfigured',
    'createdAt',
    'updatedAt'
  ];
}
