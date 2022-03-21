import 'package:flutter/material.dart';
import 'package:vendor_app/modules/login/technician_login/index.dart';
import 'package:vendor_app/utility/hex_color.dart';

class TechnicianLoginPage extends StatefulWidget {
  static const String routeName = '/technicianLogin';

  @override
  _TechnicianLoginPageState createState() => _TechnicianLoginPageState();
}

class _TechnicianLoginPageState extends State<TechnicianLoginPage> {
  final _technicianLoginBloc = TechnicianLoginBloc(UnTechnicianLoginState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('E5E5E5'),
      body: TechnicianLoginScreen(technicianLoginBloc: _technicianLoginBloc),
    );
  }
}
