import 'package:equatable/equatable.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

class TagEntity extends Equatable {
  final String id;
  final String name;
  final String slug;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;

  TagEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.createdAt,
    this.updatedAt,
    this.createdBy
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'slug': this.slug,
      'createdAt': this.createdAt?.toIso8601String(),
      'updatedAt': this.updatedAt?.toIso8601String()
    };
  }

  factory TagEntity.fromJSON(Map<String,dynamic> json) {
    return TagEntity(
      id: json['id'],
      name: json['name'] ?? "",
      slug: json['slug'],
      createdBy: json['createdBy'],
      createdAt:  json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  TagEntity copyWith({name, slug, type}) =>
      TagEntity(
        id: this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  @override
  List<Object?> get props => [
    'id',
    'name',
    'slug',
    'createdAt',
    'updatedAt'
  ];
}
