import 'package:equatable/equatable.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
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
  final double baseCurrencyAmount;
  final TransactionType transactionType;
  final String? note;
  final DateTime transactionDate;
  final CategoryEntity category;
  final AccountEntity account;
  final List<TagEntity> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionEntity({
    required this.id,
    required this.currency,
    required this.amount,
    required this.accountCurrencyAmount,
    required this.baseCurrencyAmount,
    required this.transactionType,
    this.note,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
    required this.category,
    required this.tags,
    required this.account
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'currency': this.currency.code,
      'amount': this.amount,
      'accountCurrencyAmount': this.accountCurrencyAmount,
      'baseCurrencyAmount': this.baseCurrencyAmount,
      'tags': this.tags.map((e) => e.slug).toList(),
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
      baseCurrencyAmount: double.parse(json['baseCurrencyAmount'].toString()),
      note: json['note'],
      transactionType: TransactionType.values.byName(json['transactionType']),
      transactionDate:  DateTime.parse(json['transactionDate']),
      createdAt:  json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      category: CategoryEntity.fromJSON(json['category']),
      account: AccountEntity.fromJSON(json['account']),
      tags: json['tags'] != null
          ? (json['tags'] as List).map((e) => TagEntity.fromJSON(e)).toList()
          : [],
    );
  }

  @override
  List<Object?> get props => [
    'id',
    'currency',
    'amount',
    'accountCurrencyAmount',
    'baseCurrencyAmount',
    'transactionType',
    'note',
    'transactionDate',
    'createdAt',
    'updatedAt',
    'tags'
  ];
}
