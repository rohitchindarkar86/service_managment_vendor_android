import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/models/master/refrigerant_master_model.dart';
import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';
import 'package:vendor_app/widgets/AppLoader.dart';

import '../../../models/add_inventory/add_inventory_model.dart';
import '../../../models/master/brand_master_model.dart';
import '../../../models/master/sub_applicance_master_model.dart';
import '../../../models/master/unit_qty_master_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/hex_color.dart';

class InventoryAddScreen extends StatefulWidget {
  final ServiceListModel serviceList;
  const InventoryAddScreen({
    required InventoryAddBloc inventoryAddBloc,
    required this.serviceList,
    Key? key,
  })  : _inventoryAddBloc = inventoryAddBloc,
        super(key: key);

  final InventoryAddBloc _inventoryAddBloc;

  @override
  InventoryAddScreenState createState() {
    return InventoryAddScreenState();
  }
}

class InventoryAddScreenState extends State<InventoryAddScreen> {
  InventoryAddScreenState();

  double? height;
  String selectedBrandData='';
  String selectedSubApplianceData='';

  int selectedBrandId = 0;
  int selectedSubApplianceId = 0;
  int selectedCapacityId = 0;
  int selectedGasTypeId = 0;
  bool isWarrenty = false;
  bool isApiCall = false;
  List<BrandMasterModel>? applianceBrandData;
  List<SubApplianceMasterModel>? subApplianceBrandData;
  String? qrText = '';
  TextEditingController serialNo = TextEditingController();
  TextEditingController serialNoOutdoor = TextEditingController();
  TextEditingController modelNo = TextEditingController();

  AddInventoryModel addInventoryModel = AddInventoryModel();

  List<String> yearList = [];
  List<RefrigerantMasterModel>? gasType;
  List<UnitQtyMasterModel>? unitQtyType;
  // List<String> gasType = ["R22","R332","R410","R13","R406","Others"];
  String selectedGasType="";
  String selectedCapacity="";
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

    return BlocConsumer<InventoryAddBloc, InventoryAddState>(
        bloc: widget._inventoryAddBloc,
        listener: (context, currentState) {

          if(currentState is LoadingInventoryAddState){
            isApiCall = true;
          }

          if(currentState is SuccessSubApplianceFetch){
            isApiCall = false;
            subApplianceBrandData = golbalSubApplianceMasterModel;
            widget._inventoryAddBloc.add(RefrigerantMasterEvent());
          }
          if(currentState is SuccessBrandFetch){
            isApiCall = false;
            applianceBrandData = golbalBrandMasterModel;
            widget._inventoryAddBloc.add(RefrigerantMasterEvent());
          }
          if(currentState is RefrigerantFetch){
            isApiCall = false;
            gasType = golbalRefrigerantMasterModel;
            widget._inventoryAddBloc.add(UnitQuantityMasterEvent());
          }
          if(currentState is UnitQuantityFetch){
            isApiCall = false;
            unitQtyType = golbalUnitQtyMasterModel;

          }
          if(currentState is SuccessAddInventoryFetch){
            AppUtility.showToast('Added To Inventory');
            Navigator.pop(context,true);
            isApiCall = false;
          }
          if(currentState is ErrorInventoryAddState){
            isApiCall = false;
            AppUtility.showToast(currentState.errorMessage);
          }
        },
        builder: (
            BuildContext context,
            InventoryAddState currentState,
            ) {
          height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context,false);
              return true;
            },
            child: Stack(
              children: [
                SizedBox(
                  height: height,

                  child: Column(
                    children: [
                      const SizedBox(height: 16,),
                      Expanded(
                        child:Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black54.withOpacity(0.1),
                                      blurRadius: 5.0,
                                      offset: const Offset(0.0, 0.75)
                                  ),

                                ],
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                color: Colors.white
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 6,),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                                      child: Text('${widget.serviceList.userApplianceType} - Appliance Details',maxLines:3,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 16,),)),
                                  const SizedBox(height: 6,),
                                  Divider(
                                    height: 2,
                                    thickness: 1,
                                    color:  HexColor('464646').withOpacity(0.3),
                                  ),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Appliance Type',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  subApplianceBrandData != null? Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 4),
                                      margin: const EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:DropdownButtonHideUnderline(
                                          child: DropdownSearch<SubApplianceMasterModel>(
                                          items: subApplianceBrandData!,
                                          // mode: Mode.MENU,
                                          // showSearchBox:false,
                                          // dropdownSearchDecoration: InputDecoration(labelText: selectedSubApplianceData,labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                          itemAsString: (SubApplianceMasterModel? u) => u!.description!.toString(),
                                          onChanged: (SubApplianceMasterModel? data) {
                                          selectedSubApplianceData = data!.description.toString();
                                          selectedSubApplianceId = data.key!;
                                          setState(() {
                                          });
                                          },
                                        ),
                                      )
                                  ): const SizedBox(),

                                  const SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Appliance Brand',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  applianceBrandData != null ?Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 4),
                                    margin: const EdgeInsets.only(left: 12,right: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                        borderRadius: const BorderRadius.all(Radius.circular(5))
                                    ),
                                    child:
                                    DropdownButtonHideUnderline(
                                      child: DropdownSearch<BrandMasterModel>(
                                        items: applianceBrandData!,
                                        // mode: Mode.MENU,
                                        // showSearchBox:true,
                                        // dropdownSearchDecoration: InputDecoration(labelText: selectedBrandData,labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                        itemAsString: (BrandMasterModel? u) => u!.value.toString(),
                                        onChanged: (BrandMasterModel? data) {
                                        selectedBrandData = data!.value.toString();
                                        selectedBrandId = data.key!;
                                        setState(() {

                                        });
                                        },
                                      ),
                                    ),):const SizedBox(),


                                  const SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Model No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 4),
                                      margin: const EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextField(
                                        controller: modelNo,
                                      )
                                  ),

                                  const SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Serial No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 4),
                                      margin: const EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextField(
                                        controller: serialNo,
                                      )
                                  ),
                                  selectedSubApplianceData  == "Split Air Conditioning"?const SizedBox(height: 12,):const SizedBox(),
                                  selectedSubApplianceData  == "Split Air Conditioning"?Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Serial No (Outdoor Unit)',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)):const SizedBox(),
                                  selectedSubApplianceData  == "Split Air Conditioning"?Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 4),
                                      margin: const EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextField(
                                        controller: serialNoOutdoor,
                                      )
                                  ):const SizedBox(),

                                  const SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Capacity',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  unitQtyType != null ?Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 4),
                                      margin: const EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:DropdownButtonHideUnderline(
                                        child: DropdownSearch<UnitQtyMasterModel>(
                                          items: unitQtyType!,
                                          // mode: Mode.MENU,
                                          // showSearchBox:false,
                                          // dropdownSearchDecoration: InputDecoration(labelText: selectedCapacity,labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                          itemAsString: (UnitQtyMasterModel? u) => u!.description!.toString(),
                                          onChanged: (UnitQtyMasterModel? data) {
                                          selectedCapacity = data!.description!;
                                          selectedCapacityId = data.key!;
                                          setState(() {
                                          });
                                          },
                                        ),
                                      )
                                  ):const SizedBox(),

                                  const SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Text('Gas Type',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  gasType != null ?Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 4),
                                      margin: const EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:DropdownButtonHideUnderline(
                                        child: DropdownSearch<RefrigerantMasterModel>(
                                          items: gasType!,
                                          // mode: Mode.MENU,
                                          // showSearchBox:false,
                                          // dropdownSearchDecoration: InputDecoration(labelText: selectedGasType,labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                          itemAsString: (RefrigerantMasterModel? u) => u!.description!.toString(),
                                          onChanged: (RefrigerantMasterModel? data) {
                                          selectedGasType = data!.description!;
                                          selectedGasTypeId = data.key!;
                                          setState(() {
                                          });
                                          },
                                        ),
                                      )
                                  ):const SizedBox(),

                                  const SizedBox(height: 12,),
                                  qrText!=''?Column(
                                    children: [
                                      Container(
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(left: 12),
                                          child: Text('Scanned QR',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                      Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(left: 4),
                                          margin: const EdgeInsets.only(left: 12,right: 12),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                              borderRadius: const BorderRadius.all(Radius.circular(5))
                                          ),
                                          child:Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(child: Text(qrText!)),
                                              GestureDetector(
                                                  onTap: (){
                                                    qrText = '';
                                                    setState(() {

                                                    });
                                                  },
                                                  child: const Icon(Icons.cancel,color: Colors.orange,)),
                                              const SizedBox(width: 6,)
                                            ],
                                          )

                                      ),
                                    ],
                                  ): GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/qrScanner',arguments: {"fromClick":"Yes"}).then((value)  {
                                        if(value != null) {
                                          qrText = value.toString();
                                          setState(() {

                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width,
                                        height: 45,
                                        color: Colors.orange,
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child:Row(
                                          children: [
                                            const Icon(Icons.qr_code_scanner_rounded,color: Colors.white,),
                                            Text(
                                              'Scan  Qr Code',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: Style().font_bold(),
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )

                                    ),
                                  ),


                                  const SizedBox(height: 12,),
                                ],
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          child: const Text('ADD',style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            validateAddInventory();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('ED8F2D'),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                isApiCall ? AppLoader() : Container(),
              ],
            )


          );

        });
  }

  void _load() {
    widget._inventoryAddBloc.add(ApplianceSubTypeEvent(widget.serviceList.userApplianceTypeCode!));
    widget._inventoryAddBloc.add(BrandEvent());


  }

  setAddInventoryData(){
    addInventoryModel.customerCode = widget.serviceList.customerCode;
    addInventoryModel.applianceTypeCode = widget.serviceList.userApplianceTypeCode;
    addInventoryModel.applianceSubTypeCode = selectedSubApplianceId;
    addInventoryModel.unitQuantityCode = selectedCapacityId;
    addInventoryModel.refrigerantCode = selectedGasTypeId;
    addInventoryModel.brandCode = selectedBrandId;
    addInventoryModel.baseWarrantyYears = 0;
    addInventoryModel.extendedWarrantyYears = 0;
    addInventoryModel.applianceinWarranty = isWarrenty;
    addInventoryModel.serialNumber = serialNo.text.toString();
    addInventoryModel.serialNumber_2 = serialNoOutdoor.text.toString();
    addInventoryModel.manufacturingDate = '2022-10-05T15:20:54.078Z';
    addInventoryModel.userApplianceUniqueCode = qrText.toString().replaceAll('PYSAPP', '');
    addInventoryModel.serviceRequestCode = widget.serviceList.serviceRequestCode;
    addInventoryModel.modelNumber = modelNo.text.toString();

    widget._inventoryAddBloc.add(AddInventoryEvent(addInventoryModel,widget.serviceList));
  }

   validateAddInventory(){
    if(selectedBrandId == 0){
      return  AppUtility.showToast("Please Select Brand of Appliance");
    }else if(serialNo.text.isEmpty){
      return  AppUtility.showToast("Please Enter Serial No");
    }else if(qrText == ""){
      return  AppUtility.showToast("Please Scan Qr Code");
    }else{
      setAddInventoryData();
    }
  }
}
