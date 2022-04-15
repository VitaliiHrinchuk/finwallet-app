import 'package:equatable/equatable.dart';
import 'package:finwallet_app/common/constants/currencies.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final double amount;
  final Currency currency;
  final String hexColor;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AccountEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    this.hexColor = '000000',
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'amount': this.amount,
      'currency': this.currency.code,
      'hexColor': this.hexColor,
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String()
    };
  }

  factory AccountEntity.fromJSON(Map<String,dynamic> json) {
    return AccountEntity(
      id: json['id'],
      name: json['name'] ?? "",
      amount: double.parse(json['amount'].toString()),
      currency: CURRENCIES.firstWhere((element) => element.code == json['currency']),
      hexColor: json['hexColor'] ?? "000000",
      createdAt:  json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [
    'id',
    'name',
    'amount',
    'currency',
    'hexColor',
    'createdAt',
    'updatedAt'
  ];
}
