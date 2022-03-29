import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vendor_app/modules/profile/view_profile/index.dart';
import 'package:vendor_app/utility/hex_color.dart';

import '../../../style/style.dart';
import '../../../widgets/profile/profile_widget.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({
    required ViewProfileBloc viewProfileBloc,
    Key? key,
  })  : _viewProfileBloc = viewProfileBloc,
        super(key: key);

  final ViewProfileBloc _viewProfileBloc;

  @override
  ViewProfileScreenState createState() {
    return ViewProfileScreenState();
  }
}

class ViewProfileScreenState extends State<ViewProfileScreen> {
  ViewProfileScreenState();

  double? height;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewProfileBloc, ViewProfileState>(
        bloc: widget._viewProfileBloc,
        listener: (Context, currentState) {
          if (currentState is UnViewProfileState) {}
          if (currentState is ErrorViewProfileState) {}
          if (currentState is InViewProfileState) {}
        },
        builder: (
          BuildContext context,
          ViewProfileState currentState,
        ) {
          height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 24,),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                            child: ProfileWidget.profileLableTextWidget('Job Profile Title','Ac Technician'),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            margin: EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                            child: ProfileWidget.profileLableTextWidget('Adhar Card Number','10805045097'),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            margin: EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                            child: ProfileWidget.profileLableTextWidget('Date Of Birth','10-Mar-1987'),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            margin: EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                            child: ProfileWidget.profileLableTextWidget('Blood Group','O+ve'),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }



  void _load() {
    widget._viewProfileBloc.add(LoadViewProfileEvent());
  }
}
class IdCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('ED8F2D'),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Techincian Identity Card',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
        ),
      body:  Scaffold(
        backgroundColor:Colors.white,
        body: Stack(
          children: [
            Center(
              child: GestureDetector(
                  onTap: (){
                  },
                  child:Hero(
                      tag: 'imageHero',
                      child:Container(
                          height: 500,
                          color: Colors.transparent,
                          margin: EdgeInsets.only(left: 36,right: 36,top:24,bottom: 2),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,

                                  height: 500,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //Header
                                      Container(
                                        decoration: BoxDecoration(color: HexColor('85B5CA').withOpacity(0.5),
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),)
                                        ),
                                        height: 35,
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 26,
                                              alignment: Alignment.center,
                                              child: Image.asset('assets/images/app_logo.png'),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Place',
                                                      style: TextStyle(fontFamily: Style().font_bold(),fontSize: 16,color: HexColor('#ED8F2D')),
                                                    ),
                                                    TextSpan(text: ' Your Service ',style: TextStyle(fontFamily: Style().font_regular(),fontSize: 16,color: HexColor('000000'))),
                                                  ],
                                                ),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),

                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: Container(
                                              margin: EdgeInsets.symmetric(horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 130,
                                                    child: Image.asset('assets/images/sample_img1.png'),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 4,top: 4),
                                                    child: RatingBar.builder(
                                                      ignoreGestures:true,
                                                      itemSize: 14,
                                                      initialRating: 3,
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                      itemBuilder: (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {

                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    'Kashinath Pawar',
                                                    style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
                                                  ),

                                                  SizedBox(height: 24,),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              ProfileWidget.idLableWidget('Registration No'),
                                                              ProfileWidget.idTexteWidget('123456-2022'),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(child: Container(
                                                        width: MediaQuery.of(context).size.width *0.35,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            ProfileWidget.idLableWidget('Aadhar Card No'),
                                                            ProfileWidget.idTexteWidget('99879 5626 5632'),
                                                          ],
                                                        ),
                                                      ),)
                                                      
                                                    ],
                                                  ),
                                                  SizedBox(height: 16,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child:  Container(
                                                          width: MediaQuery.of(context).size.width *0.35,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              ProfileWidget.idLableWidget('Address'),
                                                              ProfileWidget.idTexteWidget('Vartak nagar, Thane(w),400606'),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(child:  Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            ProfileWidget.idLableWidget('Blood Group'),
                                                            ProfileWidget.idTexteWidget('+Ove'),
                                                          ],
                                                        ),
                                                      ),)

                                                    ],
                                                  ),
                                                  SizedBox(height: 8,),
                                                  Container(
                                                    child: Container(
                                                      child: Image.asset('assets/images/vaccinated.png',height: 100,),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2,),

                                    ],
                                  ),
                                ),



                              ],
                            ),)
                      ))),
            ),
          ],

        ),
      )
    );
  }


}