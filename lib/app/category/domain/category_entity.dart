import 'package:equatable/equatable.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

enum CategoryType {
  DEB,
  CRE
}

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final CategoryType type;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  bool get custom => this.createdBy != null;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    this.createdAt,
    this.createdBy,
    this.updatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'slug': this.slug,
      'type': enumToShortString(this.type.toString()),
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String()
    };
  }

  factory CategoryEntity.fromJSON(Map<String,dynamic> json) {
    return CategoryEntity(
      id: json['id'],
      name: json['name'] ?? "",
      slug: json['slug'],
      type: CategoryType.values.byName(json['categoryType']),
      createdBy: json['createdBy'],
      createdAt:  json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  CategoryEntity copyWith({name, slug, type}) =>
    CategoryEntity(
      id: this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      type:  type ?? this.type,
    );

  @override
  List<Object?> get props => [
    'id',
    'name',
    'slug',
    'categoryType',
    'createdAt',
    'updatedAt'
  ];
}
