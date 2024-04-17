class Institution {
  final String? id;
  final String? name;
  final String? abbreviation;
  final String? type;
  final String? city;
  final String? state;
  final String? country;

  Institution({
    this.id,
    this.name,
    this.abbreviation,
    this.type,
    this.city,
    this.state,
    this.country,
  });

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
        id: json["id"],
        name: json["name"],
        abbreviation: json["abbreviation"],
        type: json["type"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbreviation": abbreviation,
        "type": type,
        "city": city,
        "state": state,
        "country": country,
      };
}
