import 'package:etourism_app/Utils/toast.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:provider/provider.dart';
import '../../components/locationSelectionWidget.dart';
import '../../provider/aiPlanner.provider.dart';

class AiPlannerScreen extends StatefulWidget {
  const AiPlannerScreen({Key? key}) : super(key: key);

  @override
  _AiPlannerScreenState createState() => _AiPlannerScreenState();
}

class _AiPlannerScreenState extends State<AiPlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  LatLng? _selectedLocation;
  String _selectedAddress = 'No location selected';
  double _budget = 1000;
  int _days = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "AI Trip Planner", showBackButton: false,),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CustomColors.primaryColor.withOpacity(0.1),
                    Colors.white
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              _buildTitleAndGenerateButton(),
                              SizedBox(height: 20),
                              _buildSectionTitle('Budget', Icons.attach_money),
                              SizedBox(height: 10),
                              _buildBudgetPicker(),
                              SizedBox(height: 20),
                              _buildSectionTitle('Location', Icons.location_on),
                              SizedBox(height: 10),
                              _buildLocationSelector(),
                              SizedBox(height: 20),
                              _buildSectionTitle(
                                  'Duration', Icons.calendar_today),
                              SizedBox(height: 10),
                              _buildDaysPicker(),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/travel.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndGenerateButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: CustomColors.primaryColor,
            ),
            children: [
              TextSpan(text: 'Plan Your Dream\n'),
              TextSpan(text: 'Trip'),
            ],
          ),
        ),
        SizedBox(height: 16), // Add some space between the title and the button
        CustomElevatedButton(
          onPressed: _generatePlan,
          text: 'Generate',
          backgroundColor: CustomColors.primaryColor,
          width: 120,
          height: 40,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: CustomColors.primaryColor),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CustomColors.darkGray,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetPicker() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: HorizontalPicker(
        minValue: 500,
        maxValue: 100000,
        divisions: 1000,
        height: 90,
        // initialPosition: _budget,
        suffix: " ",
        showCursor: false,
        backgroundColor: Colors.transparent,
        activeItemTextColor: CustomColors.primaryColor,
        passiveItemsTextColor: CustomColors.darkGray,
        onChanged: (value) {
          setState(() {
            _budget = value;
          });
        },
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _selectedAddress,
                style: TextStyle(fontSize: 14, color: CustomColors.darkGray),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            IconButton(
              icon: Icon(Icons.map, color: CustomColors.primaryColor),
              onPressed: _showLocationSelectionDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysPicker() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: HorizontalPicker(
        minValue: 1,
        maxValue: 30,
        divisions: 29,
        height: 90,
        // initialPosition: _days,
        suffix: " days",
        showCursor: false,
        backgroundColor: Colors.transparent,
        activeItemTextColor: CustomColors.primaryColor,
        passiveItemsTextColor: CustomColors.darkGray,
        onChanged: (value) {
          setState(() {
            _days = value.toInt();
          });
        },
      ),
    );
  }

  void _showLocationSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: LocationSelectionWidget(
              onLocationSelected: (LatLng location, String address) {
                setState(() {
                  _selectedLocation = location;
                  _selectedAddress = address;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void _generatePlan() {
    if (_formKey.currentState!.validate()) {
      if (_selectedLocation == null) {
        CustomToast().toastMessage(
          errorMsg: "Please select a location",
          bgColor: Colors.red,
        );
        return;
      }

      // Assuming you've added AiPlannerProvider to your widget tree
      final aiPlannerProvider = Provider.of<AiPlannerProvider>(context, listen: false);

      aiPlannerProvider.generateAiPlan(
        context,
        _selectedLocation!,
        _budget,
        _days,
      );
    }
  }

}
