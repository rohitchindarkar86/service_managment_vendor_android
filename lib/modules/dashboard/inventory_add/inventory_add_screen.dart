import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';
import 'package:vendor_app/widgets/AppLoader.dart';

import '../../../models/add_inventory/add_inventory_model.dart';
import '../../../models/master/brand_master_model.dart';
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
  String baseWarrantyYear='';
  String extendedWarranty='';
  int selectedBrandId = 0;
  bool isWarrenty = false;
  bool isApiCall = false;
  List<BrandMasterModel>? applianceBrandData;
  String? qrText = '';
  TextEditingController serialNo = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  AddInventoryModel addInventoryModel = AddInventoryModel();

  List<String> yearList = [];
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
        listener: (Context, currentState) {

          if(currentState is LoadingInventoryAddState){
            isApiCall = true;
          }

          if(currentState is SuccessBrandFetch){
            applianceBrandData = golbalBrandMasterModel;
          }
          if(currentState is SuccessAddInventoryFetch){
            AppUtility.showToast('Added To Inventory');
            Navigator.pop(context,true);
            isApiCall = false;
          }
          if(currentState is ErrorInventoryAddState){
            isApiCall = false;
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
                Container(
                  height: height,

                  child: Column(
                    children: [
                      SizedBox(height: 16,),
                      Expanded(
                        child:Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black54.withOpacity(0.1),
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 0.75)
                                  ),

                                ],
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.white
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 6,),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                                      child: Text('Appliance Details',maxLines:3,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 16,),)),
                                  SizedBox(height: 6,),
                                  Divider(
                                    height: 2,
                                    thickness: 1,
                                    color:  HexColor('464646').withOpacity(0.3),
                                  ),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 12),
                                      child: Text('Appliance Brand',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),

                                  Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 4),
                                    margin: EdgeInsets.only(left: 12,right: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                    child:
                                    DropdownButtonHideUnderline(
                                      child: DropdownSearch<BrandMasterModel>(
                                        items: applianceBrandData,
                                        mode: Mode.MENU,
                                        showSearchBox:true,
                                        dropdownSearchDecoration: InputDecoration(labelText: "${selectedBrandData}",labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                        itemAsString: (BrandMasterModel? u) => u!.value.toString(),
                                        onChanged: (BrandMasterModel? data) { print(data!.value.toString());
                                        selectedBrandData = data.value.toString();
                                        selectedBrandId = data.key!;
                                        setState(() {

                                        });
                                        },
                                      ),
                                    ),),
                                  SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 12,right: 12),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text('Is Appliance in Warranty :-',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                          Padding(
                                            padding: EdgeInsets.only(left: 14),
                                            child: Container(
                                                height: 20,
                                                width: 50,
                                                child: Switch(
                                                  materialTapTargetSize:
                                                  MaterialTapTargetSize.shrinkWrap,
                                                  // focusColor: Colors.amber,
                                                  onChanged: (_) {
                                                    isWarrenty = !isWarrenty;
                                                    setState(() {

                                                    });
                                                  },
                                                  value:isWarrenty,
                                                  activeColor: Colors.white,
                                                  activeTrackColor: HexColor('1e92f1'),
                                                  inactiveThumbColor: Colors.white,
                                                  inactiveTrackColor: Colors.grey,
                                                )),
                                          ),
                                        ],
                                      )
                                  ),
                                  SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 12),
                                      child: Text('Base Warranty Year',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 4),
                                      margin: EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:DropdownButtonHideUnderline(
                                        child: DropdownSearch<String>(
                                          items: yearList,
                                          mode: Mode.MENU,
                                          showSearchBox:false,
                                          dropdownSearchDecoration: InputDecoration(labelText: "${baseWarrantyYear}",labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                          itemAsString: (String? u) => u!.toString(),
                                          onChanged: (String? data) { print(data!.toString());
                                          baseWarrantyYear = data;
                                          setState(() {
                                          });
                                          },
                                        ),
                                      )
                                  ),

                                  SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 12),
                                      child: Text('Extended Warranty Year',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 4),
                                      margin: EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:DropdownButtonHideUnderline(
                                        child: DropdownSearch<String>(
                                          items: yearList,
                                          mode: Mode.MENU,
                                          showSearchBox:false,
                                          dropdownSearchDecoration: InputDecoration(labelText: "${extendedWarranty}",labelStyle: TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary,fontFamily: Style().font_regular())),
                                          itemAsString: (String? u) => u!.toString(),
                                          onChanged: (String? data) { print(data!.toString());
                                          extendedWarranty = data;
                                          setState(() {
                                          });
                                          },
                                        ),
                                      )
                                  ),

                                  SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 12),
                                      child: Text('Serial No',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 4),
                                      margin: EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextField(
                                        controller: serialNo,
                                      )
                                  ),

                                  SizedBox(height: 12,),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 12),
                                      child: Text('Manufacturing Date',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 4),
                                      margin: EdgeInsets.only(left: 12,right: 12),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child:TextField(
                                        controller: dateInput,
                                        //editing controller of this TextField
                                        decoration: InputDecoration(
                                            labelText: "" //label text of field
                                        ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime.now());

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            setState(() {
                                              dateInput.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {}
                                        },
                                      )
                                  ),

                                  SizedBox(height: 12,),
                                  qrText!=''?Column(
                                    children: [
                                      Container(
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: 12),
                                          child: Text('Scanned QR',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#000000')),)),
                                      Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 4),
                                          margin: EdgeInsets.only(left: 12,right: 12),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: HexColor('464646').withOpacity(0.3),),
                                              borderRadius: BorderRadius.all(Radius.circular(5))
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
                                                  child: Icon(Icons.cancel,color: Colors.orange,)),
                                              SizedBox(width: 6,)
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
                                        margin: EdgeInsets.symmetric(horizontal: 16),
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child:Row(
                                          children: [
                                            Icon(Icons.qr_code_scanner_rounded,color: Colors.white,),
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


                                  SizedBox(height: 12,),
                                ],
                              ),
                            )
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          child: Text('ADD'),
                          onPressed: () {
                            validateAddInventory();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: HexColor('ED8F2D'),
                              // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                              textStyle: TextStyle(
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
    widget._inventoryAddBloc.add(BrandEvent());
    DateTime now = new DateTime.now();
    int currentyear = now.year;
    for(int i =0 ;i<10;i++){
      yearList.add((i+1).toString());
    }
  }

  setAddInventoryData(){
    addInventoryModel.customerCode = widget.serviceList.customerCode;
    addInventoryModel.applianceTypeCode = widget.serviceList.userApplianceTypeCode;
    addInventoryModel.brandCode = selectedBrandId;
    addInventoryModel.baseWarrantyYears = int.parse(baseWarrantyYear.toString());
    addInventoryModel.extendedWarrantyYears = int.parse(extendedWarranty.toString());
    addInventoryModel.applianceinWarranty = isWarrenty;
    addInventoryModel.serialNumber = serialNo.text.toString();
    addInventoryModel.manufacturingDate = dateInput.text.toString();
    addInventoryModel.userApplianceUniqueCode = qrText.toString().replaceAll('PYSAPP', '');
    addInventoryModel.serviceRequestCode = widget.serviceList.serviceRequestCode;

    widget._inventoryAddBloc.add(AddInventoryEvent(addInventoryModel));
  }

   validateAddInventory(){
    if(selectedBrandId == 0){
      return  AppUtility.showToast("Please Select Brand of Appliance");
    }else if(baseWarrantyYear.isEmpty){
      return  AppUtility.showToast("Please Select Base Warranty Year");
    }else if(extendedWarranty.isEmpty){
      return  AppUtility.showToast("Please Select Extended Warranty Year");
    }else if(serialNo.text.isEmpty){
      return  AppUtility.showToast("Please Enter Serial No");
    }else if(dateInput.text.isEmpty){
      return  AppUtility.showToast("Please Select Manufacturing Date");
    }else if(qrText == ""){
      return  AppUtility.showToast("Please Scan Qr Code");
    }else{
      setAddInventoryData();
    }
  }
}
