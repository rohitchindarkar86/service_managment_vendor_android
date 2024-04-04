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
import '../../dashboard/dashboard/dashboard_page.dart';
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
  double? serviceAmt = 499;
  double? extraServiceAmt = 0;
  double? totalAmt = 0;
  String? applianceDropDownValue= "Others";
  List<ActionTakenModel> actionTakenList=[];
  List<ActionTakenModel> actionList=[];
  List<SpareMasterModel> sparePartList=[];
  List<String>? sparePartsMasterList=[];
  List<String>? checkReportMasterList=[];
  List<String>? statusMasterList=[];
  List<String>? partCode=[];
  int selectedActionMasterIndex=0;
  String selectedSpareParts='';
  List<int>? selectedPartsMasterList=[];
  bool isApiCall = false;


  static List<ResultModel> _actionTBT = [];
  var _checkReportItems;
  List<int>? _selectedActionTBT = [];

  static List<ResultModel> _action = [];
  var _statusitems;
  String _selectedStatus = '';
  var _selectedStatusId;

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
        listener: (context, currentState) {

          if(currentState is LoaderState){
            isApiCall = true;
          }
          if (currentState is CheckReportState) {
            if(_actionTBT != null){
              _actionTBT.clear();
            }
            currentState.checkReportMasterModel.forEach((element) {
              checkReportMasterList?.add(element.description.toString());
              _actionTBT.add( ResultModel(id: element.key!, name: element.description!));
            });

            if(_checkReportItems != null){
              _checkReportItems.clear();
            }
            _checkReportItems = _actionTBT
                .map((actionTBT) => MultiSelectItem<ResultModel>(actionTBT, actionTBT.name))
                .toList();
            widget._serviceReportBloc.add(PartsReplacedMasterEvent(widget.serviceList.userApplianceTypeCode!));
          }

          if (currentState is SparePartsState) {
            if(_action != null){
              _spareParts.clear();
            }
            currentState.sparePartsMasterModel.forEach((element) {
              sparePartsMasterList?.add(element.partDescription.toString());
              _spareParts.add( ResultModel(id: element.code!, name: element.partDescription!));
            });
            if(_sparePartsitems != null){
              _sparePartsitems.clear();
            }
            _sparePartsitems = _spareParts
                .map((action) => MultiSelectItem<ResultModel>(action, action.name))
                .toList();
            isApiCall = false;
            widget._serviceReportBloc.add(StatusMasterEvent());
          }

          if (currentState is StatusState) {
            if(_action != null){
              _action.clear();
            }
            currentState.statusMasterModel.forEach((element) {
              statusMasterList?.add(element.description.toString());
              _action.add( ResultModel(id: element.key!, name: element.description!));
            });
            if(_statusitems != null){
              _statusitems.clear();
            }
            _statusitems = _action
                .map((action) => MultiSelectItem<ResultModel>(action, action.name))
                .toList();
          }

          if(currentState is ActionTBTSuccessState){
            // widget._serviceReportBloc.add(UpdateActionEvent(widget.serviceList.serviceRequestCode!,widget.serviceList.serviceRequestDetailCode!,_selectedStatus!));
            widget._serviceReportBloc.add(UpdateSparePartsEvent(widget.serviceList.serviceRequestCode!,widget.serviceList.serviceRequestDetailCode!,_selectedSpareParts!));
          }

          if(currentState is SparePartsSuccessState){
            widget._serviceReportBloc.add(UpdateServiceRequestEvent(widget.serviceList.serviceRequestCode!,_selectedStatusId));

          }
          if(currentState is UpdateSuccessServiceStatusState){

              isApiCall = false;
              if(_selectedStatusId == 5 || _selectedStatusId == 9) {
                Navigator.pushReplacementNamed(context, PaymentPage.routeName,
                    arguments: {
                      "selectedRequest": widget.serviceList,
                      'fromScreen': 'ServiceReport'
                    });
              }else{
                Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);
              }

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
            child: SizedBox(
              height: height,

              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 16,),

                      Expanded(
                          child:SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                  child: const Text('Submit Service Report'),
                                  onPressed: () {
                                    serviceSubmitBottomSheet(
                                      context: context,
                                      height: height! * 0.35,);
                                    // Navigator.pushNamed(context, PaymentPage.routeName);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: HexColor('ED8F2D'),
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
                  isApiCall ? AppLoader() : Container(),
                ],
              )

            ),
          );

        });
  }

  Widget actionTakenWidget(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.only(top:0,bottom: 4),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            color: HexColor('ED8F2D').withOpacity(0.7),
            alignment: Alignment.centerLeft,
            child: const Text('Fill Service Report',style: TextStyle(color: Colors.white,fontSize: 16),),
          ),
          const SizedBox(height: 6,),
          _checkReportItems != null?Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MultiSelectDialogField(
              items: _checkReportItems,
              title: Text("Check Report",style: TextStyle(color: HexColor('000000')),),
              selectedColor: HexColor('ED8F2D'),
              searchable: true,
              searchTextStyle: const TextStyle(color:Colors.black ),
              backgroundColor: Colors.white,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          ):const SizedBox(),
          const SizedBox(height: 16,),
          _sparePartsitems != null?Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MultiSelectDialogField(
              items: _sparePartsitems,
              title: Text("Action Taken",style: TextStyle(color: HexColor('000000')),),
              selectedColor: HexColor('ED8F2D'),
              searchable: true,
              searchTextStyle: const TextStyle(color:Colors.black ),
              backgroundColor: Colors.white,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  _selectedSpareParts?.add(element.id);
                });

              },
            ),
          ):const SizedBox(),

          const SizedBox(height: 16,),
          Container(
              height: 30,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16,),
              child: Text('Status',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 4),
              margin: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: HexColor('000000').withOpacity(0.8),width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child:DropdownButtonHideUnderline(
                child: DropdownSearch<MultiSelectItem>(
                  items: _statusitems,
                  mode: Mode.MENU,
                  showSearchBox:false,
                  dropdownButtonProps: const IconButtonProps(icon:  Icon(Icons.arrow_circle_down,color: Colors.black, size: 24)),
                  dropdownSearchDecoration: InputDecoration(labelText: _selectedStatus,labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                  itemAsString: (MultiSelectItem? u) => u!.label.toString(),
                  onChanged: (MultiSelectItem? data) { print(data!.toString());
                  _selectedStatus = data.label;
                  _selectedStatusId = data.value.id!;
                  setState(() {
                  });
                  },
                ),
              )
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }

  void _load() {
    widget._serviceReportBloc.add(CheckReportsMasterEvent(widget.serviceList.userApplianceTypeCode!));
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
                : const Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                const EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                        height: 120,
                        child: Lottie.asset('assets/lottie_anim/complete_check.json')),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you Sure want to Add Service Report?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),


                    const Expanded(child: SizedBox(),),
                    Row(
                      children: [
                        Expanded(
                          child:  SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Navigator.pop(context);
                                  widget._serviceReportBloc.add(UpdateServiceCheckReportEvent(widget.serviceList.serviceRequestCode!,widget.serviceList.serviceRequestDetailCode!,_selectedActionTBT!));
                             },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child:  SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);

                              },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )),
          );
        });
  }
}
