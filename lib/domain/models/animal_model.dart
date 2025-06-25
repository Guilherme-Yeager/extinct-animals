class AnimalModel {
  int id;
  String binomialName;
  String? commonName;
  String location;
  String lastRecord;
  String wikiLink;
  String? imageSrc;
  String? shortDesc;

  AnimalModel({
    required this.id,
    required this.binomialName,
    this.commonName,
    required this.location,
    required this.wikiLink,
    required this.lastRecord,
    this.imageSrc,
    this.shortDesc,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'binomialName': binomialName,
    'commonName': commonName,
    'location': location,
    'lastRecord': lastRecord,
    'wikiLink': wikiLink,
    'imageSrc': imageSrc,
    'shortDesc': shortDesc,
  };

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'],
      binomialName: json['binomialName'],
      commonName: json['commonName'],
      location: json['location'],
      lastRecord: json['lastRecord'],
      wikiLink: json['wikiLink'],
      imageSrc: json['imageSrc'],
      shortDesc: json['shortDesc'],
    );
  }
}
