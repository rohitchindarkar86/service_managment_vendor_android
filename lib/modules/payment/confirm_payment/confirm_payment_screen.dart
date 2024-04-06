import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/payment/confirm_payment/index.dart';
import 'package:vendor_app/utility/app_utility.dart';

import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

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
        listener: (context, currentState) {
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
            child: SizedBox(
              height: height,

              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  Expanded(
                      child:SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              child:  Text(
                                'Appliance Details',
                                style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                              ),
                            ),
                            const SizedBox(height: 6,),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16,),
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
                                  const SizedBox(height: 16,),
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
                                          margin: const EdgeInsets.only(left: 8),
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
                                        margin: const EdgeInsets.only(left: 8),
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
                                  const SizedBox(height: 8,),
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
                                              margin: const EdgeInsets.only(left: 8),
                                              child: Text('Appliance Company Name',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color:  HexColor('464646').withOpacity(0.3),
                                          ),
                                          Container(
                                            height: 40,
                                            width: MediaQuery.of(context).size.width,
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(left: 8),
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
                                  const SizedBox(height: 8,),
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
                                              margin: const EdgeInsets.only(left: 8),
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
                                            margin: const EdgeInsets.only(left: 8),
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
                                  const SizedBox(height: 8,),
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
                                              margin: const EdgeInsets.only(left: 8),
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
                                            margin: const EdgeInsets.only(left: 8),
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
                                  const SizedBox(height: 8,),
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
                                              margin: const EdgeInsets.only(left: 8),
                                              child: Text('Model No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color:  HexColor('464646').withOpacity(0.3),
                                          ),
                                          Container(
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(left: 8),
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              minLines: 1,
                                              maxLines: 1,
                                              decoration:  InputDecoration(
                                                contentPadding: const EdgeInsets.only(left: 12,),
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
                                  const SizedBox(height: 8,),
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
                                              margin: const EdgeInsets.only(left: 8),
                                              child: Text('Serial No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color:  HexColor('464646').withOpacity(0.3),
                                          ),
                                          Container(
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(left: 8),
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              minLines: 1,
                                              maxLines: 1,
                                              decoration:  InputDecoration(
                                                contentPadding: const EdgeInsets.only(left: 12,),
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
                                  const SizedBox(height: 8,),
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
                                              margin: const EdgeInsets.only(left: 8),
                                              child: Text('Qr Code',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                          Divider(
                                            height: 2,
                                            thickness: 1,
                                            color:  HexColor('464646').withOpacity(0.3),
                                          ),
                                          Container(
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(left: 8,right: 8),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('$qrCodeValue',style: TextStyle(fontSize: 16,fontFamily: Style().font_regular(),color: HexColor('000000')),),
                                                GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, '/qrScanner').then((value){
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
                                  const SizedBox(height: 16,),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16,),

                          ],
                        ),
                      )
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child:   SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: const Text('Proceed To Payment'),
                              onPressed: () {
                                // Navigator.pushNamed(context, PaymentPage.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 8,),
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
