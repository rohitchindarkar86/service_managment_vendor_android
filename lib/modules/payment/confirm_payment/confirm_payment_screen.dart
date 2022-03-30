import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/payment/confirm_payment/index.dart';
import 'package:vendor_app/utility/app_utility.dart';

import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../payment/payment_page.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final String fromClick;
  final String captureCode;
  const ConfirmPaymentScreen({
    required ConfirmPaymentBloc confirmPaymentBloc,
    required this.fromClick,
    required this.captureCode,
    Key? key,
  })  : _confirmPaymentBloc = confirmPaymentBloc,
        super(key: key);

  final ConfirmPaymentBloc _confirmPaymentBloc;

  @override
  ConfirmPaymentScreenState createState() {
    return ConfirmPaymentScreenState();
  }
}

class ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  ConfirmPaymentScreenState();

  double? height;
  String? applianceDropDownValue= "AC";
  String? applianceCompanyNameDropDownValue= "Carrier";
  String? applianceDOPDropDownValue= "2021";
  String? applianceAreaDropDownValue= "Hall";
  String? qrCodeValue="";
  @override
  void initState() {
    super.initState();

    _load();
    if(widget.fromClick == "Yes"){
      qrCodeValue = widget.captureCode;
      AppUtility.showToast('Data will be auto Filled.When Qr Code is Already in Appliance');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ConfirmPaymentBloc, ConfirmPaymentState>(
        listener: (Context, currentState) {
          if (currentState is UnConfirmPaymentState) {}
          if (currentState is ErrorConfirmPaymentState) {}
          if (currentState is InConfirmPaymentState) {}
        },        bloc: widget._confirmPaymentBloc,
        builder: (
          BuildContext context,
          ConfirmPaymentState currentState,
        ) {
          height = MediaQuery.of(context).size.height;

          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Container(
              height: height,

              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Expanded(
                      child:SingleChildScrollView(
                        child: Container(

                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.centerLeft,
                                child:  Text(
                                  'Appliance Details',
                                  style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                                ),
                              ),
                              SizedBox(height: 6,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16,),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child:  Text(
                                        'Service Details',
                                        style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000')  ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child:  Text(
                                        '1234567801',
                                        style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.5)  ),
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                    Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                    ),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text('Appliance',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                        Divider(
                                          height: 2,
                                          thickness: 1,
                                          color:  HexColor('464646').withOpacity(0.3),
                                        ),
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: 8),
                                          child:
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: applianceDropDownValue,
                                              items: <String>['AC', 'Refrigerator', 'Oven', 'TV'].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value,style: TextStyle(fontSize: 16,color: HexColor('000000')),),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  applianceDropDownValue = value;
                                                });
                                              },
                                            ),
                                          ),)

                                      ],
                                    )

                                ),
                                    SizedBox(height: 8,),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(left: 8),
                                                child: Text('Appliance Comapny Name',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                            Divider(
                                              height: 2,
                                              thickness: 1,
                                              color:  HexColor('464646').withOpacity(0.3),
                                            ),
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context).size.width,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 8),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: applianceCompanyNameDropDownValue,
                                                  items: <String>['Carrier', 'LG', 'Samsung', 'Onida'].map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                ),
                                              ),)

                                          ],
                                        )

                                    ),
                                    SizedBox(height: 8,),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(left: 8),
                                                child: Text('Appliance Date Of Purchase',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                            Divider(
                                              height: 2,
                                              thickness: 1,
                                              color:  HexColor('464646').withOpacity(0.3),
                                            ),
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context).size.width,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 8),
                                              child:
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: applianceDOPDropDownValue,
                                                  items: <String>['2021', '2020', '2019', '2018'].map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                ),
                                              ),)

                                          ],
                                        )

                                    ),
                                    SizedBox(height: 8,),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(left: 8),
                                                child: Text('Appliance Area',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                            Divider(
                                              height: 2,
                                              thickness: 1,
                                              color:  HexColor('464646').withOpacity(0.3),
                                            ),
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context).size.width,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 8),
                                              child:
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: applianceAreaDropDownValue,
                                                  items: <String>['Hall', 'Kitchen', 'Bedroom1', 'Bedroom2','Bedroom3', 'Bedroom4','Other'].map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                ),
                                              ),)

                                          ],
                                        )

                                    ),
                                    SizedBox(height: 8,),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(left: 8),
                                                child: Text('Model No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                            Divider(
                                              height: 2,
                                              thickness: 1,
                                              color:  HexColor('464646').withOpacity(0.3),
                                            ),
                                            Container(
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 8),
                                              child: TextFormField(
                                                cursorColor: Colors.black,
                                                minLines: 1,
                                                maxLines: 1,
                                                decoration:  InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: 12,),
                                                  fillColor: HexColor('ED8F2D'),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: HexColor('ED8F2D')),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: HexColor('ED8F2D')),
                                                  ),

                                                ),
                                                style: TextStyle(
                                                  fontFamily: Style().font_regular(),
                                                  fontSize: 16,
                                                  color:  Colors.black,),
                                                keyboardType: TextInputType.text,
                                                // controller: EmailController,
                                              ),)

                                          ],
                                        )

                                    ),
                                    SizedBox(height: 8,),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(left: 8),
                                                child: Text('Serial No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                            Divider(
                                              height: 2,
                                              thickness: 1,
                                              color:  HexColor('464646').withOpacity(0.3),
                                            ),
                                            Container(
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 8),
                                              child: TextFormField(
                                                cursorColor: Colors.black,
                                                minLines: 1,
                                                maxLines: 1,
                                                decoration:  InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: 12,),
                                                  fillColor: HexColor('ED8F2D'),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: HexColor('ED8F2D')),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: HexColor('ED8F2D')),
                                                  ),

                                                ),
                                                style: TextStyle(
                                                  fontFamily: Style().font_regular(),
                                                  fontSize: 16,
                                                  color:  Colors.black,),
                                                keyboardType: TextInputType.text,
                                                // controller: EmailController,
                                              ),)

                                          ],
                                        )

                                    ),
                                    SizedBox(height: 8,),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                                        ),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(left: 8),
                                                child: Text('Qr Code',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                            Divider(
                                              height: 2,
                                              thickness: 1,
                                              color:  HexColor('464646').withOpacity(0.3),
                                            ),
                                            Container(
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 8,right: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('${qrCodeValue}',style: TextStyle(fontSize: 16,fontFamily: Style().font_regular(),color: HexColor('000000')),),
                                                  GestureDetector(
                                                      onTap: (){
                                                        Navigator.pushNamed(context, '/qrScanner').then((value){
                                                          print('BackClick:-'+value.toString());
                                                          if(value != null){
                                                            setState(() {
                                                              qrCodeValue = value.toString();
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Icon(Icons.camera_alt_outlined,size: 24,color: HexColor('ED8F2D'),))
                                                ],
                                              ))

                                          ],
                                        )

                                    ),
                                    SizedBox(height: 16,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16,),

                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 8,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child:   Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: Text('Proceed To Payment'),
                              onPressed: () {
                                Navigator.pushNamed(context, PaymentPage.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),
                ],
              ),
            ),
          );

        });
  }

  void _load() {
    widget._confirmPaymentBloc.add(LoadConfirmPaymentEvent());
  }
}
