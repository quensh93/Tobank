// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  website: json['website'] as String?,
  address: json['address'] == null
      ? null
      : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  company: json['company'] == null
      ? null
      : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'website': instance.website,
  'address': instance.address,
  'company': instance.company,
};

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
  street: json['street'] as String,
  suite: json['suite'] as String,
  city: json['city'] as String,
  zipcode: json['zipcode'] as String,
  geo: json['geo'] == null
      ? null
      : GeoModel.fromJson(json['geo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };

GeoModel _$GeoModelFromJson(Map<String, dynamic> json) =>
    GeoModel(lat: json['lat'] as String, lng: json['lng'] as String);

Map<String, dynamic> _$GeoModelToJson(GeoModel instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
  name: json['name'] as String,
  catchPhrase: json['catchPhrase'] as String?,
  bs: json['bs'] as String?,
);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
};

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: (json['id'] as num).toInt(),
  postId: (json['postId'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
