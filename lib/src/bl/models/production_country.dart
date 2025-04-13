/// The ProductionCountry class contains fields for the country's ISO 3166-1 code and name.
/// It also includes a factory constructor to create an instance from a JSON object.
class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(iso31661: json['iso_3166_1'], name: json['name']);
  }
}
