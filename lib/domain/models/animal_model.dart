class AnimalModel {
  final String binomialName;
  final String? commonName;
  final String location;
  final String lastRecord;
  final String wikiLink;
  final String? imageSrc;
  final String? shortDesc;

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
