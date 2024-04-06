import 'package:flutter/material.dart';
import 'package:vendor_app/modules/profile/view_profile/index.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

class ViewProfilePage extends StatefulWidget {
  static const String routeName = '/viewProfile';

  const ViewProfilePage({Key? key}) : super(key: key);

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  final _viewProfileBloc = ViewProfileBloc(UnViewProfileState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('View Profile',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      body: ViewProfileScreen(viewProfileBloc: _viewProfileBloc),
    );
  }
}
