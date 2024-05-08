import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/modules/dashboard/reached_service_details/index.dart';
import 'package:vendor_app/modules/payment/payment/payment_page.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../models/login/user_details_model.dart';
import '../../../models/service_request/order_book_list_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/cancel_request_page.dart';
import '../../payment/service_report/service_report_page.dart';
import '../inventory_add/inventory_add_page.dart';

class ReachedServiceDetailsScreen extends StatefulWidget {
  final ServiceListModel serviceList;
  const ReachedServiceDetailsScreen({
    required ReachedServiceDetailsBloc reachedServiceDetailsBloc,
    required this.serviceList,
    Key? key,
  })  : _reachedServiceDetailsBloc = reachedServiceDetailsBloc,
        super(key: key);

  final ReachedServiceDetailsBloc _reachedServiceDetailsBloc;

  @override
  ReachedServiceDetailsScreenState createState() {
    return ReachedServiceDetailsScreenState();
  }
}

class ReachedServiceDetailsScreenState extends State<ReachedServiceDetailsScreen> {
  ReachedServiceDetailsScreenState();
  double? height;

  bool isInventoryData=false;
  bool isApiCall = false;
  List<ServiceListModel>? serviceList;
  List<OrderBookListModel>? orderBookListModels=[];
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

    return BlocConsumer<ReachedServiceDetailsBloc, ReachedServiceDetailsState>(
        bloc: widget._reachedServiceDetailsBloc,
        listener: (context, currentState) {
          if (currentState is UnReachedServiceDetailsState) {}
          if (currentState is ErrorReachedServiceDetailsState) {}
          if (currentState is LoadingListDetailsState) {
            isApiCall = true;
          }
          if (currentState is InReachedServiceDetailsState) {}
          if (currentState is UpdateSuccessServiceDetailsState) {
            isApiCall = false;
            Navigator.pop(context,'updateList');
          }
          if (currentState is UpdateErrorServiceDetailsState) {
            isApiCall = false;
            AppUtility.showToast('Updated Successfully');
            Navigator.pop(context,'updateList');
          }
          if(currentState is orderHistoryListState){
            isApiCall = false;

            orderBookListModels = currentState.orderBookListModel;
            if(orderBookListModels!.isNotEmpty){
              isInventoryData = true;
            }else{
              AppUtility.showToast('No Record Found');
            }
          }

          if(currentState is NoOrderHistoryListState){
            orderBookListModels = [];
            isInventoryData = false;
            isApiCall = false;
          }
        },
        builder: (
          BuildContext context,
          ReachedServiceDetailsState currentState,
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

                            child: Column(
                              children: [
                                Container(height: 8,
                                  width: MediaQuery.of(context).size.width,
                                  color: AppUtility.serviceColorPicker(widget.serviceList.serviceStatusSysCode),),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      const SizedBox(height: 16,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${widget.serviceList.customerFirstName}  ${widget.serviceList.customerLastName}',
                                              style: TextStyle(fontSize: 16 ,fontFamily: Style().font_bold(),color: HexColor('#494949')  ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              // color: index ==  0?Colors.red.withOpacity(0.2): index ==  1? Colors.blue.withOpacity(0.2):HexColor('#18D184').withOpacity(0.2),
                                              color: AppUtility.serviceColorPicker(widget.serviceList.serviceStatusSysCode).withOpacity(0.2),
                                              borderRadius: const BorderRadius.all( Radius.circular(5)),
                                            ),
                                            child: Text(
                                              '${widget.serviceList.serviceStatus}',
                                              style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color:  AppUtility.serviceColorPicker(widget.serviceList.serviceStatusSysCode)  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Container(
                                          width: MediaQuery.of(context).size.width ,
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${widget.serviceList.addressDetails } - ${widget.serviceList.pinCode }',
                                                  maxLines: 4,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                                ),
                                              ),

                                            ],
                                          )


                                      ),
                                      const SizedBox(height: 16,),

                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16,),
                                      Text(
                                        'Job Details',
                                        style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
                                      ),
                                      const SizedBox(height: 16,),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:   Text(
                                              'Complaint ID',
                                              style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                                            ),
                                          ),
                                          Expanded(child: Text(
                                            '${widget.serviceList.serviceRequestSeriesCode}',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_bold(),color: HexColor('#000000')  ),
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:   Text(
                                              'Service Date',
                                              style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                                            ),
                                          ),
                                          Expanded(child: Text(
                                            '${widget.serviceList.scheduledDate}',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_bold(),color: HexColor('#000000')  ),
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.4,
                                            child:   Text(
                                              'Service Request',
                                              style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                                            ),
                                          ),
                                          Expanded(child: Text(
                                            '${ widget.serviceList.userApplianceType} - ${widget.serviceList.serviceCategory} - ${widget.serviceList.serviceComplaintCode?[0].description}',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_bold(),color: HexColor('#000000') ),
                                          ))
                                        ],
                                      ),
                                      const SizedBox(height: 16,),
                                    ],
                                  ),
                                ),
                                widget.serviceList.serviceStatusSysCode == 4 ? applianceDetailsWidget():const SizedBox()
                              ],
                            ),
                          )
                      ),
                      const SizedBox(height: 8,),
                      widget.serviceList.serviceStatusSysCode == 4 && isInventoryData ? Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 45,
                              margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    child: const Text(' Start Work ',style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      int selectedService = widget.serviceList.serviceRequestCode ?? 0;
                                      inProcessServiceBottomSheet(context: context,height: height! *0.40, serviceRequestCode: selectedService);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor('008d00'),
                                        // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  ElevatedButton(
                                    child: const Text('Cancel Work',style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      int selectedService =  widget.serviceList.serviceRequestCode ?? 0;
                                      cancelServiceBottomSheet(context: context,height: height! *0.4, serviceRequestCode: selectedService);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor('ea4747'),
                                        // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              )
                          ),
                          const Text('Please Check Appliance Before Filling Service Report.',style: TextStyle(fontSize: 12),),
                          const SizedBox(height: 6,),
                        ],
                      )  :const SizedBox(),
                      widget.serviceList.serviceStatusSysCode == 6  ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: ElevatedButton(
                            child: const Text('Service Report',style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              Navigator.pushNamed(context, ServiceReportPage.routeName,arguments:{"selectedRequest":widget.serviceList}).then((value){
                                if(value != null && value == true) {
                                  Navigator.pop(context,"updateList");
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('ea4747'),
                                // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ):const SizedBox(),
                      widget.serviceList.serviceStatusSysCode == 7 || widget.serviceList.serviceStatusSysCode == 8 ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child:  serviceCompleteButton(false),
                            )
                          ],
                        ),
                      ):const SizedBox(),
                      widget.serviceList.serviceStatusSysCode == 9 ||widget.serviceList.serviceStatusSysCode == 5 ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child:paymentButton(),
                            ),
                          ],
                        ),
                      ):const SizedBox(),
                      const SizedBox(height: 8,),
                    ],
                  ),
                  isApiCall ? const AppLoader() : Container(),
                ],
              )

            ),
          );
          
        });
  }

  cancelRequestBottomSheet({
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
            child: Padding(
                padding: MediaQuery.of(context).viewInsets,
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
                          height: 150,
                          child: Lottie.asset('assets/lottie_anim/complete_check.json')),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Are you sure wanted to cancel request?',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: Style().font_bold(),
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child:Text('Cancel Reason',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.50)),),
                      ),
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                    ),
                    child:TextFormField(
                      cursorColor: Colors.black,
                      minLines: 3,
                      maxLines: 3,
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
                    )
                ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          child: const Text('Yes',style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, CancelRequestPage.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('ED8F2D'),
                              // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.center,
                        child:
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text('Close',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  )),
            ),
          );
        });
  }

  completeRequestBottomSheet({
    required BuildContext context,
    required double height,
    required bool showNote,
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
                        'Are you Sure to Complete this Service Request?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                    showNote? Container(
                      alignment: Alignment.center,
                      child: Text(
                        '\nNote :-Please click No to add appliance to inventory, if not added',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Style().font_regular(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ):const SizedBox(),

                    const Expanded(child: SizedBox(),),
                    Row(
                      children: [
                        Expanded(
                          child:  SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: const Text('Yes',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                Navigator.pop(context);
                                widget._reachedServiceDetailsBloc.add(UpdateServiceRequestEvent(widget.serviceList.serviceRequestCode,9));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor('ED8F2D'),
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
                              child: const Text('No',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                Navigator.pop(context);

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

                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )),
          );
        });
  }

  partsReplaceBottomSheet({
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
                        'Are you Sure Service Request Parts is Pending?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '\nNote :-Please click No to add appliance to inventory, if not added',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Style().font_regular(),
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
                              child: const Text('Yes',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                Navigator.pop(context);
                                widget._reachedServiceDetailsBloc.add(UpdateServiceRequestEvent(widget.serviceList.serviceRequestCode,7));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor('ED8F2D'),
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
                              child: const Text('No',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                Navigator.pop(context);

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

                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )),
          );
        });
  }

  applianceDetailsWidget(){
    return  !isInventoryData  ? Container(
      width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child:   Text(
              !isInventoryData?'Is there any QR code on Appliance?':'Click below button for Appliance Details',
              style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
            ),
          ),
          const SizedBox(height: 8,),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/qrScanner').then((value){
                if(value != null) {
                  widget._reachedServiceDetailsBloc.add(GetInventoryEvent(value.toString()));
                }
              });
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                alignment: Alignment.center,
                color:  HexColor('ED8F2D'),
                child: Text(!isInventoryData?'If Yes Please Scan QR Code.':'Please Scan QR Code',style: TextStyle(fontSize: 16,color: HexColor('#FFFFFF'),fontFamily: Style().font_medium()),)
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 8,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child:   Text(
                  'OR',
                  style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
                ),
              ),
              const SizedBox(height: 8,),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, InventoryAddPage.routeName,arguments: {"selectedRequest":widget.serviceList}).then((value) {
                    _load();
                  });
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    alignment: Alignment.center,
                    color:  HexColor('ED8F2D'),
                    child: Text('Product QR-Code Mapping',style: TextStyle(fontSize: 16,color: HexColor('#FFFFFF'),fontFamily: Style().font_medium()),)
                ),
              ),
            ],
          )
        ],
      ),
    ):Column(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Appliance Order History',maxLines:1,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 14,color: Colors.black),),),
              ],
            )),
        (orderBookListModels!=null && orderBookListModels!.isNotEmpty) ? ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemBuilder: complaintList,
          itemCount: orderBookListModels?.length ??0,
        ):Container(
          margin: const EdgeInsets.only(top: 16),
          child: const Text('No Records Found'),
        ),
      ],
    );
  }

  void _load() async{
    widget._reachedServiceDetailsBloc.add(LoadReachedServiceDetailsEvent());
    String keyTOGetData = userDetailsModel!.vendorUserCode.toString() +'_'+ widget.serviceList.serviceRequestCode.toString();
    final inventoryData =  await AppUtility.DataFromLocal(keyTOGetData);
    if(inventoryData != null){
      isInventoryData = true;
    }else{
      isInventoryData = false;
    }
    setState(() {

    });
  }

  serviceCompleteButton(showNote){
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ElevatedButton(
        child: const Text('Service Complete',style: TextStyle(color: Colors.white),),
        onPressed: () {
          completeRequestBottomSheet(context: context,height: height! *0.38,showNote:showNote);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('008d00'),
            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  paymentButton(){
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ElevatedButton(
        child: const Text('Proceed To Payment',style: TextStyle(color: Colors.white),),
        onPressed: () {
          Navigator.pushNamed(context, PaymentPage.routeName,arguments: {"selectedRequest":widget.serviceList,'fromScreen':''});
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('008d00'),
            textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget complaintList(BuildContext context, int index) {
    OrderBookListModel orderBookListModel =orderBookListModels![index];
    return Container(
        margin: const EdgeInsets.only(top: 8),
        color: Colors.white,
        child:
        Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Order No - ${orderBookListModel.serviceRequestSeriesCode}',maxLines:1,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 12,color: Theme.of(context).colorScheme.secondary),),),
                  ],
                )),
            const SizedBox(
              height: 8,
            ),
            Container(
              // height: 100,
              padding: const EdgeInsets.only(top: 0,left: 16,right: 0),
              alignment: Alignment.centerLeft,
              child: Text('Order Service - ${orderBookListModel.createdDate}',maxLines:1,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 12,color: Theme.of(context).colorScheme.secondary),),
            ),

            const SizedBox(
              height: 8,
            ),
            Container(
              // height: 100,
              padding: const EdgeInsets.only(top: 0,left: 16,right: 0),
              alignment: Alignment.centerLeft,
              child: Text('${orderBookListModel.serviceRequestDetails![0].applianceName} - ${orderBookListModel.serviceCategory} - ${orderBookListModel.serviceRequestDetails?[0].serviceComplaintCode?[0].description}',maxLines:1,style: TextStyle(fontFamily: Style().font_regular(),fontSize: 16,color: Theme.of(context).colorScheme.secondary),),
            ),
            const SizedBox(
              height: 8,
            ),

          ],
        )


    );
  }

  inProcessServiceBottomSheet({
    required BuildContext context,
    required double height,
    required int serviceRequestCode
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
                        height: 150,
                        child: Lottie.asset('assets/lottie_anim/start_work.json')),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you sure you want to Start the Work.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    const SizedBox(
                      height: 36,
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: const Text('Continue',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.pop(context);
                          widget._reachedServiceDetailsBloc.add(UpdateServiceRequestEvent(widget.serviceList.serviceRequestCode,6));

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('ED8F2D'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(LocaleKeys.ReachLocationCancelBtn.tr(),style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )),
          );
        });
  }

  cancelServiceBottomSheet({
    required BuildContext context,
    required double height,
    required int serviceRequestCode,
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
                        height: 150,
                        child: Lottie.asset('assets/lottie_anim/cancel_request.json')),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you sure you want to Cancel Service.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    const SizedBox(
                      height: 36,
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: const Text('Cancel Service',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.pop(context);
                          widget._reachedServiceDetailsBloc.add(UpdateServiceRequestEvent(widget.serviceList.serviceRequestCode,5));

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('ea4747'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(LocaleKeys.ReachLocationCancelBtn.tr(),style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )),
          );
        });
  }
}
