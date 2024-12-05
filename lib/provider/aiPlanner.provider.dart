import 'package:etourism_app/Services/services.dart';
import 'package:etourism_app/Utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../screens/aiPlanner/apPlannerResponse.dart';

class AiPlannerProvider with ChangeNotifier {
  final _service = Services();
  late String error;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  Map<String, dynamic>? _generatedPlan;
  Map<String, dynamic>? get generatedPlan => _generatedPlan;

  Future<void> generateAiPlan(
      BuildContext context,
      LatLng coordinates,
      double budget,
      int days) async {
    context.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();

    final planDetails = {
      'coordinates': [coordinates.latitude, coordinates.longitude],
      'budget': budget,
      'days': days,
    };

    await _service.generateAiPlan(
      planDetails: planDetails,
      onSuccess: (plan) async {
        _generatedPlan = plan['data'];
        CustomToast().toastMessage(errorMsg: "AI Plan generated successfully", bgColor: Colors.green);
        _isLoading = false;
        notifyListeners();

        // Navigate to the AiPlannerResult screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AiPlannerResult()),
        );
        context.loaderOverlay.hide();
      },
      onError: (e) {
        _isLoading = false;
        error = e.toString();
        CustomToast().toastMessage(errorMsg: error, bgColor: Colors.red);
        notifyListeners();
        context.loaderOverlay.hide();
      },
    );
  }
}