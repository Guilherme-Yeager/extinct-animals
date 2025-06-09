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
}
