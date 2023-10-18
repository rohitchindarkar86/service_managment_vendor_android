import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:vendor_app/modules/payment/service_report/index.dart';

import '../../../models/master/spare_parts_master_model.dart';
import '../../../models/service_request/action_taken_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/success_request_page.dart';
import '../payment/payment_page.dart';

class ServiceReportScreen extends StatefulWidget {
  final ServiceListModel serviceList;
  const ServiceReportScreen({
    required ServiceReportBloc serviceReportBloc,
    required this.serviceList,
    Key? key,
  })  : _serviceReportBloc = serviceReportBloc,
        super(key: key);

  final ServiceReportBloc _serviceReportBloc;

  @override
  ServiceReportScreenState createState() {
    return ServiceReportScreenState();
  }
}
class ResultModel {
  final int id;
  final String name;

  ResultModel({
    required this.id,
    required this.name,
  });
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
  List<ActionTakenModel> actionList=[];
  List<SpareMasterModel> sparePartList=[];
  List<String>? sparePartsMasterList=[];
  List<String>? actionTakenMasterList=[];
  List<String>? actionMasterList=[];
  List<String>? partCode=[];
  int selectedActionMasterIndex=0;
  String selectedSpareParts='';
  List<int>? selectedPartsMasterList=[];
  bool isApiCall = false;


  static List<ResultModel> _actionTBT = [];
  var _actionTBTitems;
  List<int>? _selectedActionTBT = [];

  static List<ResultModel> _action = [];
  var _actionitems;
  List<int>? _selectedAction = [];

  static List<ResultModel> _spareParts = [];
  var _sparePartsitems;
  List<int>? _selectedSpareParts = [];

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

          if(currentState is LoaderState){
            isApiCall = true;
          }
          if (currentState is ActionTakenState) {
            currentState.actionTakenMasterModel.forEach((element) {
              actionTakenMasterList?.add(element.description.toString());
              _actionTBT.add( ResultModel(id: element.key!, name: element.description!));
            });
            _actionTBTitems = _actionTBT
                .map((actionTBT) => MultiSelectItem<ResultModel>(actionTBT, actionTBT.name))
                .toList();
            widget._serviceReportBloc.add(ActionMasterEvent(widget.serviceList.userApplianceTypeCode!));
          }
          if (currentState is ActionState) {
            currentState.actionTakenMasterModel.forEach((element) {
              actionMasterList?.add(element.description.toString());
              _action.add( ResultModel(id: element.key!, name: element.description!));
            });
            _actionitems = _action
                .map((action) => MultiSelectItem<ResultModel>(action, action.name))
                .toList();
            widget._serviceReportBloc.add(PartsReplacedMasterEvent(widget.serviceList.userApplianceTypeCode!));
          }
          if (currentState is SparePartsState) {

            currentState.sparePartsMasterModel.forEach((element) {
              sparePartsMasterList?.add(element.partDescription.toString());
              _spareParts.add( ResultModel(id: element.applianceType_Code!, name: element.partDescription!));
            });
            _sparePartsitems = _spareParts
                .map((action) => MultiSelectItem<ResultModel>(action, action.name))
                .toList();
            isApiCall = false;
          }

          if(currentState is ActionTBTSuccessState){
            widget._serviceReportBloc.add(UpdateActionEvent(widget.serviceList.serviceRequestCode!,widget.serviceList.serviceRequestDetailCode!,_selectedAction!));
          }
          if(currentState is ActionSuccessState){
            widget._serviceReportBloc.add(UpdateSparePartsEvent(widget.serviceList.serviceRequestCode!,widget.serviceList.serviceRequestDetailCode!,_selectedSpareParts!));

          }
          if(currentState is SparePartsSuccessState){
            widget._serviceReportBloc.add(UpdateServiceRequestEvent(widget.serviceList.serviceRequestCode!,6));

          }
          if(currentState is UpdateSuccessServiceStatusState){

              isApiCall = false;

              Navigator.pushReplacementNamed(context, PaymentPage.routeName,
                  arguments: {"selectedRequest": widget.serviceList,'fromScreen':'ServiceReport'});

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

              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 16,),

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
                                            child: actionTakenWidget(context)),



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
                                  child: Text('Submit Service Report'),
                                  onPressed: () {
                                    serviceSubmitBottomSheet(
                                      context: context,
                                      height: height! * 0.35,);
                                    // Navigator.pushNamed(context, PaymentPage.routeName);
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
                  isApiCall ? AppLoader() : Container(),
                ],
              )

            ),
          );

        });
  }

  Widget actionTakenWidget(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(top:0,bottom: 4),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            color: HexColor('ED8F2D').withOpacity(0.7),
            alignment: Alignment.centerLeft,
            child: Text('Fill Service Report',style: TextStyle(color: Colors.white,fontSize: 16),),
          ),
          SizedBox(height: 6,),
          _actionTBTitems != null?Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MultiSelectDialogField(
              items: _actionTBTitems,
              title: Text("Check Report"),
              selectedColor: HexColor('ED8F2D'),
              searchable: true,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: HexColor('464646'),
                  width: 2,
                ),
              ),
              buttonIcon: Icon(
                Icons.arrow_circle_down,
                color: HexColor('464646'),
              ),
              buttonText: Text(
                "Check Report",
                style: TextStyle(
                  color:HexColor('464646'),
                  fontSize: 16,
                ),
              ),
              onConfirm: (List<ResultModel> results) {
                results.forEach((element) {
                  _selectedActionTBT?.add(element.id);
                });

              },
            ),
          ):SizedBox(),
          SizedBox(height: 16,),
          _actionitems != null?Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MultiSelectDialogField(
              items: _actionitems,
              title: Text("Action Taken"),
              selectedColor: HexColor('ED8F2D'),
              searchable: true,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: HexColor('464646'),
                  width: 2,
                ),
              ),
              buttonIcon: Icon(
                Icons.arrow_circle_down,
                color: HexColor('464646'),
              ),
              buttonText: Text(
                "Action Taken",
                style: TextStyle(
                  color:HexColor('464646'),
                  fontSize: 16,
                ),
              ),
              onConfirm: (List<ResultModel> results) {
                results.forEach((element) {
                  _selectedAction?.add(element.id);
                });

              },
            ),
          ):SizedBox(),
          SizedBox(height: 16,),
          _sparePartsitems != null?Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MultiSelectDialogField(
              items: _sparePartsitems,
              title: Text("Status"),
              selectedColor: HexColor('ED8F2D'),
              searchable: true,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: HexColor('464646'),
                  width: 2,
                ),
              ),
              buttonIcon: Icon(
                Icons.arrow_circle_down,
                color: HexColor('464646'),
              ),
              buttonText: Text(
                "Status",
                style: TextStyle(
                  color:HexColor('464646'),
                  fontSize: 16,
                ),
              ),
              onConfirm: (List<ResultModel> results) {
                results.forEach((element) {
                  _selectedSpareParts?.add(element.id);
                });

              },
            ),
          ):SizedBox(),
          SizedBox(height: 16,),
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
    sparePartList.add(SpareMasterModel());
    setState(() {
    });
  }

  _removeExtraWork(index){
    actionTakenList.removeAt(index);
    sparePartList.removeAt(index);
    setState(() {
    });
  }
  void _load() {
    _addExtraWorkToList();
    widget._serviceReportBloc.add(ActionTakenMasterEvent(widget.serviceList.userApplianceTypeCode!));

  }

  serviceSubmitBottomSheet({
    required BuildContext context,
    required double height,

  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                        height: 120,
                        child: Lottie.asset('assets/lottie_anim/complete_check.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you Sure want to Service Report?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),


                    Expanded(child: Container(),),
                    Container(

                      child: Row(
                        children: [
                          Expanded(
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: ElevatedButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  Navigator.pop(context);
                                    widget._serviceReportBloc.add(UpdateServiceCheckReportEvent(widget.serviceList.serviceRequestCode!,widget.serviceList.serviceRequestDetailCode!,_selectedActionTBT!));
                               },
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor('ED8F2D'),
                                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: ElevatedButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);

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

                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                )),
          );
        });
  }
}
