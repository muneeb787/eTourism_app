class LocationModel {
  String address;
  String city;
  String state;
  String country;
  double latitude;
  double longitude;

  LocationModel({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  // From JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    print('Json in Location model ${json}');
    return LocationModel(
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      latitude: json['coordinates'][1].toDouble() ?? 0,
      longitude: json['coordinates'][0].toDouble() ?? 0,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'coordinates': {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
  }
}
