
class Plat {
  Plat({this.prix, this.description, this.name, this.images});

  final String name;
  final String images;
  final String prix;
  final String description;


  Plat.fromJson(Map<String, dynamic> json)
      : name = json['plat'],
        images = json['images'],
        prix = json['prix'],
        description = json['description'];
}
