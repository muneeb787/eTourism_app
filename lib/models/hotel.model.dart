import 'package:etourism_app/models/location.model.dart';
import 'package:etourism_app/models/room.model.dart';

class HotelModel {
  String? id;
  String managerId;
  String logoUrl;
  String bannerUrl;
  String name;
  LocationModel location;
  String? about;
  double rating;
  bool isActive;
  bool isVerified;
  List<RoomModel>? rooms;

  HotelModel({
    this.id,
    required this.managerId,
    this.logoUrl = 'https://res.cloudinary.com/dwlmgckgg/image/upload/v1696854667/yf9gdc96fse0msfsbs2e.jpg',
    this.bannerUrl = 'https://res.cloudinary.com/dwlmgckgg/image/upload/v1696854667/yf9gdc96fse0msfsbs2e.jpg',
    required this.name,
    required this.location,
    this.about,
    this.rating = 3.0,
    this.isActive = true,
    this.isVerified = true,
    this.rooms,
  });

  // From JSON
  factory HotelModel.fromJson(Map<String, dynamic> json) {
    print("json in HotelModel ${json}");
    return HotelModel(
      id: json['_id'] as String?,
      managerId: json['managerId'] as String,
      logoUrl: json['logoUrl'] as String? ?? 'https://res.cloudinary.com/dwlmgckgg/image/upload/v1696854667/yf9gdc96fse0msfsbs2e.jpg',
      bannerUrl: json['bannerUrl'] as String? ?? 'https://res.cloudinary.com/dwlmgckgg/image/upload/v1696854667/yf9gdc96fse0msfsbs2e.jpg',
      name: json['name'] as String,
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      about: json['about'] as String?,
      rating: json['rating'].toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      isVerified: json['isVerified'] as bool? ?? true,
      rooms: json['rooms'] != null && (json['rooms'] as List).isNotEmpty
          ? List<RoomModel>.from(json['rooms'].map((room) => RoomModel.fromJson(room)))
          : [], // Handle case where rooms may be an empty array or not present
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'managerId': managerId,
      'logoUrl': logoUrl,
      'bannerUrl': bannerUrl,
      'name': name,
      'location': location.toJson(),
      'about': about,
      'rating': rating,
      'isActive': isActive,
      'isVerified': isVerified,
      'rooms': rooms?.map((room) => room.toJson()).toList(), // Convert rooms to JSON if they exist, even if empty
    };
  }
}
