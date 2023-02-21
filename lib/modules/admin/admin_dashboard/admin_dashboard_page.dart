import 'package:flutter/material.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/admin_dashboard_screen.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/index.dart';
import 'package:vendor_app/utility/hex_color.dart';

class AdminDashboardPage extends StatefulWidget {
  static const String routeName = '/admin_dashboard';

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final _dashboardBloc = AdminDashboardBloc(UnDashboardState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5E5E5'),
      body: AdminDashboardScreen(dashboardBloc: _dashboardBloc),
    );
  }
}
