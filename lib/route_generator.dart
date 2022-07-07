import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';
import 'package:vendor_app/widgets/success_password_fetch.dart';

import 'modules/dashboard/reached_service_details/index.dart';
import 'modules/login/otp_verification/otp_verification_page.dart';
import 'modules/login/technician_login/technician_login_page.dart';
import 'modules/payment/confirm_payment/confirm_payment_page.dart';
import 'modules/payment/payment/payment_page.dart';
import 'modules/payment/service_report/service_report_page.dart';
import 'modules/profile/view_profile/view_profile_page.dart';
import 'modules/scanner/qr_scanner.dart';
import 'modules/splash_screen/splash_screen.dart';
import 'widgets/cancel_request_page.dart';
import 'widgets/success_request_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          // settings omitted to hide route name
        );

      case TechnicianLoginPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => TechnicianLoginPage(),
        );
        case OtpVerificationPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => OtpVerificationPage(),
          settings: settings
        );

      case DashboardPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => DashboardPage(),
        );

      case ViewProfilePage.routeName:
        return MaterialPageRoute(
          builder: (builder) => ViewProfilePage(),
        );

      case ReachedServiceDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => ReachedServiceDetailsPage(),
          settings: settings
        );

      case CancelRequestPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => CancelRequestPage(),
        );

      case SuccessRequestPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => SuccessRequestPage(),
        );
      case SuccessPasswordPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => SuccessPasswordPage(),
            settings: settings
        );
      case ConfirmPaymentPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => ConfirmPaymentPage(),
            settings: settings
        );
        case PaymentPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => PaymentPage(),
        );

      case ServiceReportPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => ServiceReportPage(),
        );
      case '/qrScanner':
        return MaterialPageRoute(
          builder: (context) => QRScanner(),
          settings: settings
          // settings omitted to hide route name
        );
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (builder) {
      return Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
