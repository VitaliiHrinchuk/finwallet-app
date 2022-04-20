import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

class TransactionsListFilters {
  final DateTime? startDate;
  final DateTime? endDate;
  final int limit;
  final List<AccountEntity>? accounts;
  final List<CategoryEntity>? categories;
  final TransactionType? type;


  TransactionsListFilters({
    this.startDate,
    this.endDate,
    this.accounts,
    this.type,
    this.categories,
    this.limit = 999
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> filters = {
      "startDate": startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      "limit": limit.toString(),
      "accounts": accounts?.map((e) => e.id).toList(),
      "categories": categories?.map((e) => e.slug).toList(),
      "type": type != null ? enumToShortString(type.toString()) : null
    };

    filters.removeWhere((key, value) => value == null);

    return filters;
  }

  TransactionsListFilters copyWith({
    startDate,
    endDate,
    limit,
    Optional<List<AccountEntity>>? accounts,
    Optional<List<CategoryEntity>>? categories,
    Optional<TransactionType>? type
  }) =>
      TransactionsListFilters(
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          limit: limit ?? this.limit,
          accounts: accounts != null ? accounts.value : this.accounts,
          categories: categories != null ? categories.value : this.categories,
          type: type != null ? type.value : this.type,
      );
}

