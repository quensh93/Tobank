// lib/dummy/models/user_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.website,
    this.address,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? website;
  final AddressModel? address;
  final CompanyModel? company;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  const AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel? geo;

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class GeoModel {
  const GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) => _$GeoModelFromJson(json);

  final String lat;
  final String lng;

  Map<String, dynamic> toJson() => _$GeoModelToJson(this);
}

@JsonSerializable()
class CompanyModel {
  const CompanyModel({
    required this.name,
    this.catchPhrase,
    this.bs,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);

  final String name;
  final String? catchPhrase;
  final String? bs;

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}

@JsonSerializable()
class PostModel {
  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  final int id;
  final int userId;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class CommentModel {
  const CommentModel({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

















