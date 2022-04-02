import 'package:equatable/equatable.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

enum TransactionType {
  DEB,
  CRE
}

class TransactionEntity extends Equatable {
  final String id;
  final Currency currency;
  final double amount;
  final double accountCurrencyAmount;
  final TransactionType transactionType;
  final String? note;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionEntity({
    required this.id,
    required this.currency,
    required this.amount,
    required this.accountCurrencyAmount,
    required this.transactionType,
    this.note,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'currency': this.currency.code,
      'amount': this.amount,
      'accountCurrencyAmount': this.accountCurrencyAmount,
      'transactionType': enumToShortString(this.transactionType.toString()),
      'note': this.note,
      'transactionDate': this.transactionDate.toIso8601String(),
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String()
    };
  }

  factory TransactionEntity.fromJSON(Map<String,dynamic> json) {
    return TransactionEntity(
      id: json['id'],
      currency: CURRENCIES.firstWhere((element) => element.code == json['currency']),
      amount: double.parse(json['amount'].toString()),
      accountCurrencyAmount: double.parse(json['accountCurrencyAmount'].toString()),
      note: json['note'],
      transactionType: TransactionType.values.byName(json['transactionType']),
      transactionDate:  DateTime.parse(json['transactionDate']),
      createdAt:  json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  @override
  List<Object?> get props => [
    'id',
    'currency',
    'amount',
    'accountCurrencyAmount',
    'transactionType',
    'note',
    'transactionDate',
    'createdAt',
    'updatedAt'
  ];
}
