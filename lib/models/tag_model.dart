class OptionsTag {
  final int id;
  final String name;
  final String image;
  const OptionsTag({this.id, this.name, this.image});
  factory OptionsTag.fromJson(Map<String, dynamic> json) {
    return OptionsTag(
      id: json["id"],
      name: json["name"],
      image: json['image_url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.image;
    return data;
  }

  Map<String, dynamic> toDBJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Tag {
  final int id;
  final String name;
  final OptionsTag tagGroup;

  const Tag({this.name, this.id, this.tagGroup});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json["id"],
      name: json["name"],
      tagGroup: OptionsTag.fromJson(
        json['tag_group'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.tagGroup != null) {
      data['tag_group'] = this.tagGroup.toJson();
    }
    return data;
  }

  Map<String, dynamic> toDBJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.tagGroup != null) {
      data['tag_group'] = this.tagGroup.toDBJson();
    }
    return data;
  }
}
