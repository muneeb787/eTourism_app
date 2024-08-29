import 'package:etourism_app/models/location.model.dart';

class PlaceModel {
  final String id;
  final String image;
  final String name;
  LocationModel location;
  final double? rating;

  PlaceModel({
    required this.id,
    required this.image,
    required this.name,
    required this.location,
    this.rating,
  });

  // Factory constructor to create a Place from JSON
  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    print("json ${json}");
    return PlaceModel(
      id: json['_id'],
      image: json['image'],
      name: json['name'],
      location: LocationModel.fromJson(json['location']),
      rating: json['rating'] != null ? json['rating'].toDouble() : null,
    );
  }

  // Method to convert a Place object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'name': name,
      'location': location,
      'rating': rating,
    };
  }
}
