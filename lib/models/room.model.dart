import 'package:etourism_app/models/hotel.model.dart';

class RoomModel {
  String? id;
  String hotelId;
  int roomNumber;
  String type;
  double price;
  bool availability;
  List<String>? amenities;
  List<String>? photos;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;

  RoomModel({
    this.id,
    required this.hotelId,
    required this.roomNumber,
    required this.type,
    required this.price,
    this.availability = true,
    this.amenities,
    this.photos,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['_id'] as String?,
      hotelId: json['hotelId'] as String,
      roomNumber: json['roomNumber'],
      type: json['type'] as String,
      price: json['price'].toDouble(),
      availability: json['availability'] as bool? ?? true,
      amenities: json['amenities'] != null ? List<String>.from(json['amenities']) : null,
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'hotelId': hotelId,
      'roomNumber': roomNumber,
      'type': type,
      'price': price,
      'availability': availability,
      'amenities': amenities,
      'photos': photos,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
