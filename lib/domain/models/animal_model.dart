class AnimalModel {
  String binomialName;
  String? commonName;
  String location;
  String lastRecord;
  String wikiLink;
  String? imageSrc;
  String? shortDesc;

  AnimalModel({
    required this.binomialName,
    this.commonName,
    required this.location,
    required this.wikiLink,
    required this.lastRecord,
    this.imageSrc,
    this.shortDesc,
  });

  Map<String, dynamic> toJson() => {
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
