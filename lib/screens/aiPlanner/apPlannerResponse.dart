import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etourism_app/provider/aiPlanner.provider.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Hotels/hotelView.screen.dart';

class AiPlannerResult extends StatelessWidget {
  const AiPlannerResult({Key? key}) : super(key: key);

  final String fallbackImageUrl =
      'https://static.vecteezy.com/system/resources/previews/002/034/969/original/modern-house-villa-exterior-with-swimming-pool-at-backyard-illustration-vector.jpg';

  @override
  Widget build(BuildContext context) {
    final aiPlannerProvider = Provider.of<AiPlannerProvider>(context);
    final planData = aiPlannerProvider.generatedPlan;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Your AI Travel Plan",
        showBackButton: true,
      ),
      body: planData == null
          ? Center(child: Text("No plan generated yet."))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHotelSection(planData['hotels']),
            _buildItinerarySection(planData['itinerary']),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelSection(List<dynamic> hotels) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Recommended Hotels",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColors.primaryColor,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: hotels.map((hotel) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelViewScreen(
                            hotelId: hotel['_id'] ?? ""),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: NetworkImage(hotel['bannerUrl']),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                fallbackImageUrl,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel['name'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                hotel['about'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 18),
                                  SizedBox(width: 4),
                                  Text(
                                    "${hotel['rating']}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildItinerarySection(List<dynamic> itinerary) {
    // This part remains unchanged
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Itinerary",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColors.primaryColor,
            ),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itinerary.length,
            itemBuilder: (context, index) {
              final day = itinerary[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Day ${day['day']}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      ...day['activities'].map<Widget>((activity) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.circle, size: 8, color: CustomColors.primaryColor),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  activity,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}