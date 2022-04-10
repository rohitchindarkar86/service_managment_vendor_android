import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/reached_service_details/index.dart';

import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

class ReachedServiceDetailsPage extends StatefulWidget {
  static const String routeName = '/reachedServiceDetails';

  @override
  _ReachedServiceDetailsPageState createState() => _ReachedServiceDetailsPageState();
}

class _ReachedServiceDetailsPageState extends State<ReachedServiceDetailsPage> {
  final _reachedServiceDetailsBloc = ReachedServiceDetailsBloc(UnReachedServiceDetailsState());
  late String fromClick;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments  as Map;
    fromClick = arguments['fromClick'].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('On Going Service',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      backgroundColor: HexColor('#E5E5E5'),
      resizeToAvoidBottomInset: false,
      body: ReachedServiceDetailsScreen(reachedServiceDetailsBloc: _reachedServiceDetailsBloc,fromClick:fromClick),
    );
  }
}
