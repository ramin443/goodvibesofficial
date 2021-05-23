class LoginTextModel {
  String text;
  String description;

  LoginTextModel({this.text, this.description});

  LoginTextModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['description'] = this.description;
    return data;
  }
}
