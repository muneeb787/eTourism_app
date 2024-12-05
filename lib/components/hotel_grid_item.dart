import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Utils/customColors.dart';
import '../models/hotel.model.dart';
import '../screens/Hotels/hotelView.screen.dart';

class HotelGridItem extends StatelessWidget {
  final HotelModel hotel;
  static const String fallbackImageUrl =
      'https://static.vecteezy.com/system/resources/previews/002/034/969/original/modern-house-villa-exterior-with-swimming-pool-at-backyard-illustration-vector.jpg';

  const HotelGridItem({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => _navigateToHotelDetail(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHotelImage(),
            _buildHotelInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelImage() {
    return Expanded(
      child: Hero(
        tag: 'hotel-${hotel.id}',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                child: CachedNetworkImage(
                  imageUrl: hotel.logoUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildImagePlaceholder(),
                  errorWidget: (context, url, error) => CachedNetworkImage(
                    imageUrl: fallbackImageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildImagePlaceholder(),
                  ),
                ),
              ),
              _buildImageOverlay(),
              _buildFavoriteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildImageOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            // Implement favorite functionality
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.favorite_border,
              size: 20,
              color: CustomColors.darkGray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHotelInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.darkGray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildRatingBar(),
          const SizedBox(height: 4),
          _buildScrollableAmenitiesRow(context),
        ],
      ),
    );
  }

  Widget _buildRatingBar() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < (hotel.rating ?? 0).floor()
                ? Icons.star
                : Icons.star_border,
            size: 18,
            color: Colors.amber,
          );
        }),
        const SizedBox(width: 4),
        Text(
          hotel.rating?.toStringAsFixed(1) ?? "N/A",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableAmenitiesRow(BuildContext context) {
    // Example list of amenities - replace with actual data from your HotelModel
    final amenities = [
      {'icon': Icons.wifi, 'label': 'WiFi'},
      {'icon': Icons.local_parking, 'label': 'Parking'},
      {'icon': Icons.pool, 'label': 'Pool'},
      {'icon': Icons.restaurant, 'label': 'Restaurant'},
      {'icon': Icons.spa, 'label': 'Spa'},
      {'icon': Icons.fitness_center, 'label': 'Gym'},
      // Add more amenities as needed
    ];

    return SizedBox(
      height: 32, // Fixed height for the row
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: amenities.length, // +1 for the see more button
        itemBuilder: (context, index) {

          // Show amenity chip
          return Padding(
            padding: EdgeInsets.only(
              right: 8,
              left: index == 0 ? 0 : 0,
            ),
            child: _buildAmenityChip(
              amenities[index]['icon'] as IconData,
              amenities[index]['label'] as String,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAmenityChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: CustomColors.darkGray),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: CustomColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  void _showAllAmenities(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildAmenitiesBottomSheet(context),
    );
  }

  Widget _buildAmenitiesBottomSheet(BuildContext context) {
    // Example amenities list - replace with actual data from your HotelModel
    final amenities = [
      {'icon': Icons.wifi, 'label': 'WiFi'},
      {'icon': Icons.local_parking, 'label': 'Parking'},
      {'icon': Icons.pool, 'label': 'Pool'},
      {'icon': Icons.restaurant, 'label': 'Restaurant'},
      {'icon': Icons.spa, 'label': 'Spa'},
      {'icon': Icons.fitness_center, 'label': 'Gym'},
      // Add more amenities
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Amenities',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities.map((amenity) {
              return _buildAmenityChip(
                amenity['icon'] as IconData,
                amenity['label'] as String,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _navigateToHotelDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelViewScreen(hotelId: hotel.id ?? ""),
      ),
    );
  }
}