import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_appbar.dart';
import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Terms And Condition",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            """Welcome to Travel Mate! By using our website and services, you agree to these Terms and Conditions. Please read them carefully.

Acceptance of Terms
By accessing and using Travel Mate, you accept and agree to be bound by these Terms and Conditions and our Privacy Policy. If you do not agree, you must stop using our services immediately.

User Accounts

Registration: To use certain features of Travel Mate, you must create an account. You are responsible for maintaining the confidentiality of your account credentials.
Eligibility: You must be at least 18 years old to create an account on Travel Mate. By registering, you confirm that you meet this age requirement.
Account Responsibility: You are responsible for all activities that occur under your account. You agree to notify us immediately of any unauthorized use or security breach.
User Conduct

Prohibited Activities: You agree not to engage in any unlawful activities, post harmful or inappropriate content, or attempt to hack or disrupt the platform.
Content Ownership: You retain ownership of the content you post, but grant Travel Mate a license to use, modify, and display this content as necessary to provide the services.
Content Removal: We reserve the right to remove any content that violates these Terms or is deemed inappropriate.
Bookings and Payments

Hotel and Cab Bookings: All bookings made through Travel Mate are subject to availability. The booking process and payment terms will be detailed during the transaction process.
Payment Methods: You must provide accurate and complete payment information. Failure to process payment may result in the cancellation of your booking.
Cancellations and Refunds: Cancellation and refund policies for bookings are governed by the respective hotel, cab service, or tour operator. Please review these policies carefully before making a booking.
Intellectual Property

Ownership: All content, features, and functionality on Travel Mate, including but not limited to text, graphics, logos, and software, are the intellectual property of Travel Mate or its licensors.
Use of Content: You may not """,
            style: TextStyle(
              fontSize: 20,
              color: CustomColors.darkGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
