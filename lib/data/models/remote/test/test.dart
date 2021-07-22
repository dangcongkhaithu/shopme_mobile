import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable()
class Test {
  final String birthday;
  final String known_for_department;
  final String deathday;
  final int id;
  final String name;
  final List<String> also_known_as;
  final int gender;
  final String biography;
  final int popularity;
  final String place_of_birth;
  final String profile_path;
  final bool adult;
  final String imdb_id;
  final String homepage;

  Test(this.birthday, this.known_for_department, this.deathday, this.id, this.name, this.also_known_as, this.gender,
      this.biography, this.popularity, this.place_of_birth, this.profile_path, this.adult, this.imdb_id, this.homepage);

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}
