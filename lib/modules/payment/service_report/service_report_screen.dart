import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/payment/service_report/index.dart';

import '../../../models/service_request/action_taken_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/success_request_page.dart';
import '../payment/payment_page.dart';

class ServiceReportScreen extends StatefulWidget {
  const ServiceReportScreen({
    required ServiceReportBloc serviceReportBloc,
    Key? key,
  })  : _serviceReportBloc = serviceReportBloc,
        super(key: key);

  final ServiceReportBloc _serviceReportBloc;

  @override
  ServiceReportScreenState createState() {
    return ServiceReportScreenState();
  }
}

class ServiceReportScreenState extends State<ServiceReportScreen> {
  ServiceReportScreenState();

  double? height;
  int _extraWorkRadioValue1=1;
  int _paymentRadioValue1=0;
  double? serviceAmt = 499;
  double? extraServiceAmt = 0;
  double? totalAmt = 0;
  String? applianceDropDownValue= "Others";
  List<ActionTakenModel> actionTakenList=[];
  List<String>? actionTakenMasterList=[];
  int selectedActionMasterIndex=0;

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
    return BlocConsumer<ServiceReportBloc, ServiceReportState>(
        listener: (Context, currentState) {

          if (currentState is ActionTakenState) {
            currentState.actionTakenMasterModel.forEach((element) {
              actionTakenMasterList?.add(element.description.toString());
            });

          }

        },
        bloc: widget._serviceReportBloc,
        builder: (
            BuildContext context,
            ServiceReportState currentState,
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
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fill Service Report',
                            style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: (){
                                      _addExtraWorkToList();
                                    }, child: Row(
                                  children: [
                                    Icon(Icons.add_circle_outline,size: 24,color: HexColor('ED8F2D')),
                                    SizedBox(width: 4,),
                                    Text('Add',style: TextStyle(fontSize: 16,fontFamily: Style().font_medium(),color: HexColor('ED8F2D')),)
                                  ],
                                ))
                              ],
                            ),
                          )
                        ],)


                  ),
                  Expanded(
                      child:SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [

                              Container(

                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      // margin: EdgeInsets.only(top: 13),
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(top: 0),
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: actionTakenList.length,
                                            itemBuilder: actionTakenWidget)),



                                  ],
                                ),
                              ),

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
                                Navigator.pushNamed(context, PaymentPage.routeName);;
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

  Widget actionTakenWidget(BuildContext context, int index) {
    return   Container(
      margin: EdgeInsets.only(top:0,bottom: 4),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24,
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            color: HexColor('ED8F2D').withOpacity(0.7),
            alignment: Alignment.centerLeft,
            child: Text('Action Taken ${index + 1}',style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 6,),
          Container(
            width: MediaQuery.of(context).size.width *0.8,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Action',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: HexColor('464646').withOpacity(0.3)),

            ),
            child:DropdownSearch<String>(
              //mode of dropdown
              mode: Mode.BOTTOM_SHEET,
              //to show search box
              showSearchBox: true,
              // showSelectedItem: true,
              //list of dropdown items
              items: actionTakenMasterList,
              // label: "Country",
              onChanged: (val){
                actionTakenList[index].actionTaken=val;
              },
              //show selected item
              selectedItem: actionTakenList[index].actionTaken,

            ),),
          SizedBox(height: 16,),
          Container(
            width: MediaQuery.of(context).size.width *0.8,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Part Replaced',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: HexColor('464646').withOpacity(0.3)),

            ),
            child:DropdownSearch<String>(
              //mode of dropdown
              mode: Mode.BOTTOM_SHEET,
              //to show search box
              showSearchBox: true,
              // showSelectedItem: true,
              //list of dropdown items
              items: actionTakenMasterList,
              // label: "Country",
              onChanged: (val){
                actionTakenList[index].partReplaced=val;
              },
              //show selected item
              selectedItem: actionTakenList[index].partReplaced,

            ),),
          actionTakenList.length != 1?Container(
            margin: EdgeInsets.only(left: 16,right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  _removeExtraWork(index);
                }, child: Row(
                  children: [
                    Icon(Icons.remove_circle_outline,size: 20,color: Colors.red),
                    SizedBox(width: 4,),
                    Text('Remove',style: TextStyle(fontSize: 14,fontFamily: Style().font_medium(),color: Colors.red),)
                  ],
                ))
              ],
            ),
          ):Container(),
          actionTakenList.length == 1 ?SizedBox(height: 12,):Container()

        ],
      ),
    );
  }

  _addExtraWorkToList(){
    ActionTakenModel actionTakenModel = new ActionTakenModel();
    actionTakenModel.actionTaken = "";
    actionTakenModel.part_msyscd = "";
    actionTakenModel.partReplaced = "";
    actionTakenModel.partAmount = "0.0";
    actionTakenList.add(actionTakenModel);
    setState(() {
    });
  }

  _removeExtraWork(index){
    actionTakenList.removeAt(index);
    setState(() {
    });
  }
  void _load() {
    _addExtraWorkToList();
    widget._serviceReportBloc.add(ActionTakenMasterEvent());
  }
}
