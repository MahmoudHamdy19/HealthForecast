class ArticleModel {
  String? name;
  String? description;
  String? type;
  DateTime? date;
   String? image;
   String? id;

  ArticleModel(this.name, this.description, this.type, this.date,
    this.image, {this.id});
  ArticleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    type = json['type'];
    date = DateTime.parse(json['date']);
    image = json['image'];
   }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['date'] = date?.toIso8601String();
    data['image'] = image;
     return data;
  }

}