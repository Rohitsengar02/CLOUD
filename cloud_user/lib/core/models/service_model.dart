import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: '_id') // MongoDB often uses _id
  final String id;
  final String title;
  final String? description;
  final double price;
  final String? image;
  final String category;
  final String? subCategory;
  final int? duration; // in minutes
  final double? rating;
  final int? reviewCount;

  ServiceModel({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.image,
    required this.category,
    this.subCategory,
    this.duration,
    this.rating,
    this.reviewCount,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
