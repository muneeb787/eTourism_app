import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/components/placeItem.dart';
import 'package:etourism_app/provider/places.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesByCategory extends StatefulWidget {
  final String category;
  const PlacesByCategory({super.key, required this.category});

  @override
  State<PlacesByCategory> createState() => _PlacesByCategoryState();
}

class _PlacesByCategoryState extends State<PlacesByCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PlacesProvider>(context, listen: false)
        .fetchPlacesByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Places at ${widget.category}",
        showBackButton: true,
        onBackButtonPressed: () => {Navigator.pop(context)},
      ),
      body: SingleChildScrollView(
        child: Consumer<PlacesProvider>(
          builder: (context, data, child) {
            if (data.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                height: 150,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    childAspectRatio:
                        3 / 2, // Width / height ratio of each grid item
                    crossAxisSpacing: 10, // Horizontal space between items
                    mainAxisSpacing: 10, // Vertical space between items
                  ),
                  itemCount: data.placesByCategory.length,
                  itemBuilder: (context, index) {
                    final item = data.placesByCategory[index];
                    print("❤️❤️ Hotel Item: ${item}");
                    return PlaceItem(
                      id: item.id,
                      image: item.image,
                      name: item.name,
                      location: item.location,
                      rating: item.rating?.toDouble() ?? 0,
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
