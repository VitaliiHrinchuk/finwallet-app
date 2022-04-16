import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/common/contracts.dart';

class AnalyticsFilters {
  final DateTime? startDate;
  final DateTime? endDate;
  final AccountEntity? account;

  AnalyticsFilters({
    this.startDate,
    this.endDate,
    this.account,
  });

  Map<String, dynamic> toJson() {
    return {
      "startDate": startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      "accountId": account?.id
    };
  }

  AnalyticsFilters copyWith({startDate, endDate, Optional<AccountEntity>? account}) =>
      AnalyticsFilters(
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          account: account != null ? account.value : this.account
      );
}
