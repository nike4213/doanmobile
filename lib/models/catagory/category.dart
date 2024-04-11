import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;




Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Category toJson() => _$CategoryFromJson(this as Map<String, dynamic>);

}