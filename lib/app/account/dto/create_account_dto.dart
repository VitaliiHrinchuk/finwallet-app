class CreateAccountDto {
  final double? amount;
  final String? currency;
  final String? name;
  final String? hexColor;

  CreateAccountDto({
    required this.amount,
    required this.name,
    required this.currency,
    this.hexColor
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "name": name,
    "hexColor": hexColor,
  };

}