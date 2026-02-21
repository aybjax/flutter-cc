// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoritesStateImpl _$$FavoritesStateImplFromJson(Map<String, dynamic> json) =>
    _$FavoritesStateImpl(
      favorites:
          (json['favorites'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FavoritesStateImplToJson(
  _$FavoritesStateImpl instance,
) => <String, dynamic>{'favorites': instance.favorites};
