import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/dashboard/index.dart';
import 'package:vendor_app/utility/hex_color.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _dashboardBloc = DashboardBloc(UnDashboardState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5E5E5'),
      body: DashboardScreen(dashboardBloc: _dashboardBloc),
    );
  }
}
