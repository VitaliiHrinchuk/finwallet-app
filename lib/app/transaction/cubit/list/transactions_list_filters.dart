import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/common/contracts.dart';

class TransactionsListFilters {
  final DateTime? startDate;
  final DateTime? endDate;
  final AccountEntity? account;
  final int limit;

  TransactionsListFilters({
    this.startDate,
    this.endDate,
    this.account,
    this.limit = 999
  });

  Map<String, dynamic> toJson() {
    return {
      "startDate": startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      "limit": limit.toString(),
      "accountId": account?.id
    };
  }

  TransactionsListFilters copyWith({startDate, endDate, limit, Optional<AccountEntity>? account}) =>
      TransactionsListFilters(
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          limit: limit ?? this.limit,
          account: account != null ? account.value : this.account
      );
}

