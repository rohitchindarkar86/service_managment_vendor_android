import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';
import 'package:vendor_app/widgets/success_password_fetch.dart';

import 'modules/dashboard/inventory_add/inventory_add_page.dart';
import 'modules/dashboard/reached_service_details/index.dart';
import 'modules/login/otp_verification/otp_verification_page.dart';
import 'modules/login/technician_login/technician_login_page.dart';
import 'modules/payment/confirm_payment/confirm_payment_page.dart';
import 'modules/payment/payment/payment_page.dart';
import 'modules/payment/service_report/service_report_page.dart';
import 'modules/profile/notification/notification/notification_page.dart';
import 'modules/profile/view_profile/view_profile_page.dart';
import 'modules/scanner/qr_scanner.dart';
import 'modules/splash_screen/splash_screen.dart';
import 'widgets/cancel_request_page.dart';
import 'widgets/success_request_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
   // final args = settings.arguments;

    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          // settings omitted to hide route name
        );

      case TechnicianLoginPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const TechnicianLoginPage(),
        );
        case OtpVerificationPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const OtpVerificationPage(),
          settings: settings
        );

      case DashboardPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => DashboardPage(),
        );

      case ViewProfilePage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const ViewProfilePage(),
        );

      case ReachedServiceDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const ReachedServiceDetailsPage(),
          settings: settings
        );

      case CancelRequestPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const CancelRequestPage(),
        );

      case SuccessRequestPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const SuccessRequestPage(),
        );
      case SuccessPasswordPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const SuccessPasswordPage(),
            settings: settings
        );
      case ConfirmPaymentPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const ConfirmPaymentPage(),
            settings: settings
        );
        case PaymentPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const PaymentPage(),
            settings: settings
        );

      case ServiceReportPage.routeName:
        return MaterialPageRoute(
          builder: (builder) => const ServiceReportPage(),
            settings: settings
        );
      case '/qrScanner':
        return MaterialPageRoute(
          builder: (context) => const QRScanner(),
          settings: settings
          // settings omitted to hide route name
        );
        case InventoryAddPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const InventoryAddPage(),
          settings: settings
          // settings omitted to hide route name
        );
      case NotificationPage.routeName:
        return MaterialPageRoute(
            builder: (builder) => const NotificationPage(),
            settings: settings
        );
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (builder) {
      return const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
