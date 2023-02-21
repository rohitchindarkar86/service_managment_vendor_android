
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/admin_dashboard_bloc.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/index.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/LogoutOverlay.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../../dashboard/repository/admin_repository.dart';


class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({
    required AdminDashboardBloc dashboardBloc,
    Key? key,
  })  : _dashboardBloc = dashboardBloc,
        super(key: key);

  final AdminDashboardBloc _dashboardBloc;

  @override
  AdminDashboardScreenState createState() {
    return AdminDashboardScreenState();
  }
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  AdminDashboardScreenState();

  double? height;

  bool isApiCall = false;
  bool isServiceLoader = true;
  SharedPreferences? sharedPreferences;

  String? techName = "";
  List<ServiceListModel>? serviceList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminDashboardBloc, AdminDashboardState>(
        bloc: widget._dashboardBloc,
        listener: (Context, currentState) {
          if (currentState is UnDashboardState) {

          }
          if (currentState is LoadingDashboardState) {
            if (currentState.indexLoader == 0) {
              isApiCall = true;
            } else if (currentState.indexLoader == 1) {
              isServiceLoader = true;
            }
          }
          if (currentState is ErrorDashboardState) {
            isApiCall = false;
          }
          if (currentState is GeneratedQrState) {
            isApiCall = false;
            createPdf(currentState.pdfPath);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PdfWidget(currentState.pdfPath)));

          }
        },
        builder: (BuildContext context,
            AdminDashboardState currentState,) {
          height = MediaQuery
              .of(context)
              .size
              .height;
          return WillPopScope(
              onWillPop: () async {
                showDialog(
                  context: context,
                  builder: (_) => LogoutOverlay('Exit'),
                );
                return true;
              },
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: height! * 0.25,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),

                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 0.75)
                              )
                            ],
                            color: HexColor('ED8F2D'),
                          ),
                          child: SafeArea(
                            child: Stack(
                              children: [
                                Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 30,
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          child: GestureDetector(
                                              onTap: () {
                                                // AppUtility.logoutUser;
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      LogoutOverlay('Logout'),
                                                );
                                              },
                                              child: Icon(
                                                Icons.logout, size: 25,
                                                color: Colors.white,)),
                                        ),
                                      ],
                                    )

                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 85,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 24),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              8.0),
                                          child: Image.asset(
                                              'assets/images/sample_img.png'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Admin Login',
                                                style: TextStyle(
                                                    fontFamily: Style()
                                                        .font_regular(),
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Expanded(
                          child: Column(
                            children: [

                              itemDrawer(
                                  context, "Generate QR For Printing", Icons
                                  .print_outlined, () async {

                                setState(() {
                                  isApiCall = true;
                                });
                                File? file = await getContent('.pdf');
                                if (file != null) {
                                  final String? result = await _launchURL(file.path.toString());
                                  if (result != null) {
                                    print('result');
                                    print(result);
                                    // Warning
                                  }
                                }
                              })
                            ],
                          ),
                        ),

                      ],
                    )

                    ,
                  ),
                  isApiCall ? AppLoader() : Container(),
                ],
              )

          );
        });
  }

  itemDrawer(context, itemName, IconData itemIcon, onTapFunction) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        // leading:SvgPicture.asset('assets/icons/drawer/logout_icon.svg', semanticsLabel: 'Logout'),
        title: Row(
          children: [
            Icon(itemIcon, size: 24, color: Colors.orange,),
            SizedBox(width: 32,),
            Expanded(child: Text(
              itemName, style: TextStyle(fontSize: 16, color: Theme
                .of(context)
                .colorScheme
                .secondary, fontFamily: Style().font_bold()),)),
            Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Theme
                .of(context)
                .colorScheme
                .secondary,)
          ],),
        onTap: onTapFunction,
      ),
    );
  }

  createPdf(base64String) async {
    var bytes = base64Decode(base64String.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/pdf_qr.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());

    print("${output.path}/pdf_qr.pdf");
    await OpenFile.open("${output.path}/pdf_qr.pdf");
    setState(() {});
  }

  _launchURL(String urlpath) async {
    await OpenFile.open(urlpath);
    setState(() {
      isApiCall = false;
    });

  }

  Future<File?> getContent(String extension) async {
//this is the api mentioned in next part
  try{
    var body = {
      "code": 40
    };
    http.Response res = await AdminRepository.apiCall(body);
    dynamic response = res.bodyBytes;

    if (response != null) {
      final Directory? appDir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String tempPath = appDir!.path;
      final String fileName =
          DateTime
              .now()
              .microsecondsSinceEpoch
              .toString() + extension;
      File file = File('$tempPath/$fileName');
      if (!await file.exists()) {
        await file.create();
      }
      await file.writeAsBytes(response);
      return file;
    }
  }catch(e){
    print(e.toString());
  }
  }
}
