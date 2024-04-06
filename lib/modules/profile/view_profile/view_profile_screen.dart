import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vendor_app/modules/profile/view_profile/index.dart';
import 'package:vendor_app/utility/hex_color.dart';

import '../../../models/login/user_details_model.dart';
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
        listener: (context, currentState) {
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
            child: Column(
              children: [
                const SizedBox(height: 24,),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                        child: ProfileWidget.profileLableTextWidget('Job Profile Title','Ac Technician'),
                      ),
                      const SizedBox(height: 16,),
                      Container(
                        margin: const EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                        child: ProfileWidget.profileLableTextWidget('Aadhaar Card Number','10805045097'),
                      ),
                      const SizedBox(height: 16,),
                      Container(
                        margin: const EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                        child: ProfileWidget.profileLableTextWidget('Date Of Birth','10-Mar-1987'),
                      ),
                      const SizedBox(height: 16,),
                      Container(
                        margin: const EdgeInsets.only(left: 24,right: 24,top:0,bottom: 0),
                        child: ProfileWidget.profileLableTextWidget('Blood Group','O+ve'),
                      )
                    ],
                  ),
                ),

              ],
            ),
          );
        });
  }



  void _load() {
    widget._viewProfileBloc.add(LoadViewProfileEvent());
  }
}
class IdCardScreen extends StatelessWidget {

  String techName='';
  String registrationNo='';
  String aadhaarCardNo='';
  String address='';
  String bloodGroup='';

  IdCardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getUserDetailsModel();
    techName = (userDetailsModel?.technicianName)!;
    registrationNo = (userDetailsModel?.userCode.toString())!;
    aadhaarCardNo = (userDetailsModel?.uidaI_Aadhar.toString())!;
    bloodGroup = (userDetailsModel?.bloodGroup_Desc.toString())!;
    address = (userDetailsModel?.addressLine_1??"")+" "+(userDetailsModel?.addressLine_2 ??"");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('ED8F2D'),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Technician Identity Card',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
        ),
      body:  Scaffold(
        backgroundColor:Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: GestureDetector(
                    onTap: (){
                    },
                    child:Hero(
                        tag: 'imageHero',
                        child:Container(
                            height: 520,
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(left: 36,right: 36,top:24,bottom: 2),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child:Stack(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,

                                    height: 520,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //Header
                                        Container(
                                          decoration: BoxDecoration(color: HexColor('85B5CA').withOpacity(0.5),
                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),)
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
                                              const SizedBox(
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
                                        const SizedBox(height: 20,),

                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: Container(
                                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 130,
                                                      child: Image.asset('assets/images/sample_img1.png'),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.only(left: 4,top: 4),
                                                      child: RatingBar.builder(
                                                        ignoreGestures:true,
                                                        itemSize: 14,
                                                        initialRating: 3,
                                                        minRating: 1,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                        itemBuilder: (context, _) => const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate: (rating) {

                                                        },
                                                      ),
                                                    ),
                                                    Text(techName,
                                                      style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
                                                    ),

                                                    const SizedBox(height: 24,),

                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              ProfileWidget.idLableWidget('Registration No'),
                                                              ProfileWidget.idTexteWidget(registrationNo),
                                                            ],
                                                          ),
                                                        ),

                                                        Expanded(child: SizedBox(
                                                          width: MediaQuery.of(context).size.width *0.35,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              ProfileWidget.idLableWidget('Aadhaar Card No'),
                                                              ProfileWidget.idTexteWidget(aadhaarCardNo),
                                                            ],
                                                          ),
                                                        ),)
                                                        
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child:  SizedBox(
                                                            width: MediaQuery.of(context).size.width *0.35,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                ProfileWidget.idLableWidget('Issue Date'),
                                                                ProfileWidget.idTexteWidget('02 Jan 2021'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(child:  Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            ProfileWidget.idLableWidget('Blood Group'),
                                                            ProfileWidget.idTexteWidget(bloodGroup),
                                                          ],
                                                        ),)

                                                      ],
                                                    ),
                                                    const SizedBox(height: 8,),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        ProfileWidget.idLableWidget('Address'),
                                                        ProfileWidget.idTexteWidget(address),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8,),
                                                    Image.asset('assets/images/vaccinated.png',height: 100,),

                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 2,),

                                      ],
                                    ),
                                  ),



                                ],
                              ),)
                        ))),
              ),
            ),
          ],

        ),
      )
    );
  }


}