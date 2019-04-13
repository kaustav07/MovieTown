// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movieModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieV2 _$MovieV2FromJson(Map<String, dynamic> json) {
  return MovieV2(
      json['Title'] as String,
      json['Year'] as String,
      json['imdbID'] as String,
      json['Type'] as String,
      json['Poster'] as String);
}

Map<String, dynamic> _$MovieV2ToJson(MovieV2 instance) => <String, dynamic>{
      'Title': instance.Title,
      'Year': instance.Year,
      'imdbID': instance.imdbID,
      'Type': instance.Type,
      'Poster': instance.Poster
    };

MovieSearchResponse _$MovieSearchResponseFromJson(Map<String, dynamic> json) {
  return MovieSearchResponse(
      (json['Search'] as List)
          ?.map((e) =>
              e == null ? null : MovieV2.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['totalResults'] as String,
      json['Response'] as String);
}

Map<String, dynamic> _$MovieSearchResponseToJson(
        MovieSearchResponse instance) =>
    <String, dynamic>{
      'Search': instance.Search,
      'totalResults': instance.totalResults,
      'Response': instance.Response
    };
