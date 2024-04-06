import 'package:flutter/material.dart';
import 'package:vendor_app/modules/login/otp_verification/index.dart';

class OtpVerificationPage extends StatefulWidget {
  static const String routeName = '/otpVerification';

  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpVerificationBloc = OtpVerificationBloc(UnOtpVerificationState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpVerificationScreen(otpVerificationBloc: _otpVerificationBloc),
    );
  }
}
