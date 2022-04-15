class UpdateAccountDto {
  final String? name;
  final String? hexColor;
  final String id;

  UpdateAccountDto({
    required this.name,
    required this.id,
    this.hexColor
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "hexColor": hexColor,
  };

}