import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Privacy Policy",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            """Welcome to Travel Mate! We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our website and services.

1. Information We Collect
Personal Information: We may collect personal information such as your name, email address, phone number, and payment details when you register, make bookings, or interact with our services.
        Usage Data: We collect information on how you use our services, including your IP address, browser type, operating system, and pages visited.
        Cookies: We use cookies and similar tracking technologies to track activity on our website and store certain information. Cookies help us understand your preferences and improve our services.
2. How We Use Your Information
Personalization: We use your information to tailor your experience on Travel Mate, including generating personalized tour plans.
        Service Improvement: Your data helps us to understand user behavior and improve our services.
        Communication: We may use your contact information to send you updates, promotions, and other relevant information about Travel Mate.
        Security: We use your information to detect and prevent fraud and maintain the security of our platform.
3. Sharing Your Information
Service Providers: We may share your information with third-party service providers who assist us in delivering our services.
        Legal Requirements: We may disclose your information if required by law or to protect our rights and safety.
4. Your Choices
        Account Information: You can update your account information at any time by logging into your account settings.

Cookies: You can choose to disable cookies through your browser settings, but this may affect your experience on our site.
        Marketing Communications: You can opt-out of receiving marketing emails from us by following the unsubscribe link in the email.
5. Security
We implement appropriate technical and organizational measures to protect your personal information. However, no method of transmission over the internet is completely secure, and we cannot guarantee absolute security.

6. Children's Privacy
Our services are not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected such information, we will take steps to delete it.

7. Changes to This Policy
We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the new policy on this page.

8. Contact Us
If you have any questions about this Privacy Policy, please contact us at [Insert Contact Information].""",
            style: TextStyle(
                fontSize: 20,
                color: CustomColors.darkGray,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
