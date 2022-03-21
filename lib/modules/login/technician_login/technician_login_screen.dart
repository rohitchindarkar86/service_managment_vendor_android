import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/login/technician_login/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';
import 'package:vendor_app/widgets/login/forgot_email_success_widget.dart';

class TechnicianLoginScreen extends StatefulWidget {
  const TechnicianLoginScreen({
    required TechnicianLoginBloc technicianLoginBloc,
    Key? key,
  })  : _technicianLoginBloc = technicianLoginBloc,
        super(key: key);

  final TechnicianLoginBloc _technicianLoginBloc;

  @override
  TechnicianLoginScreenState createState() {
    return TechnicianLoginScreenState();
  }
}

class TechnicianLoginScreenState extends State<TechnicianLoginScreen> {
  TechnicianLoginScreenState();

  double? height;

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController forgotPassEmailController = TextEditingController();


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
    return BlocConsumer<TechnicianLoginBloc, TechnicianLoginState>(
        bloc: widget._technicianLoginBloc,
        listener: (Context, currentState) {
          if (currentState is UnTechnicianLoginState) {}
          if (currentState is ErrorTechnicianLoginState) {}
          if (currentState is InTechnicianLoginState) {}
        },
        builder: (
          BuildContext context,
          TechnicianLoginState currentState,
        ) {
          height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
            },
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height! * 0.20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Image.asset('assets/images/app_logo.png'),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Place',
                                      style: TextStyle(fontFamily: Style().font_bold(),fontSize: 24,color: HexColor('#ED8F2D')),
                                    ),
                                    TextSpan(text: ' Your Service ',style: TextStyle(fontFamily: Style().font_regular(),fontSize: 24,color: HexColor('000000'))),
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Technician Login',
                                      style: TextStyle(fontFamily: Style().font_regular(),fontSize: 16,color: HexColor('#000000')),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(
                              height: height! * 0.08,
                            ),
                            Container(
                                height: 40,
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration:  InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    fillColor: HexColor('ED8F2D'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: HexColor('ED8F2D')),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: HexColor('ED8F2D')),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: Style().font_regular(),
                                      fontSize: 16,
                                      color: Colors.grey,),
                                    hintText: "Enter Email Id",
                                  ),
                                  style: TextStyle(
                                    fontFamily: Style().font_regular(),
                                    fontSize: 16,
                                    color:  Colors.black,),
                                  keyboardType: TextInputType.text,
                                  controller: EmailController,
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                                height: 40,
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child:  TextFormField(
                                  cursorColor: Colors.black,
                                  decoration:  InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    fillColor: HexColor('ED8F2D'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: HexColor('ED8F2D')),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: HexColor('ED8F2D')),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: Style().font_regular(),
                                      fontSize: 16,
                                      color: Colors.grey,),
                                    hintText: "Enter Password",
                                  ),
                                  style: TextStyle(
                                    fontFamily: Style().font_regular(),
                                    fontSize: 16,
                                    color:  Colors.black,),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  controller: PasswordController,
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              margin: EdgeInsets.only(top: 4, left: 24, right: 24),
                              child: ElevatedButton(
                                child: Text('SIGN IN'),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/dashboard');
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor('ED8F2D'),
                                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(top: 10, left: 24, right: 24),
                                child: GestureDetector(
                                  onTap: (){
                                    forgotPasswordBottomSheet(context: context,height: (height!*0.3));
                                  },
                                  child:   RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Forgot your password?',
                                          style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: HexColor('#393838').withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )

                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 10, left: 24, right: 24),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child:   RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Registration Will Be Done By Respective\nVendor',
                                style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: HexColor('#393838').withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                      )

                  ),
                ],
              )

              ,
            ),
          );
        });
  }

  forgotPasswordBottomSheet({
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
                      alignment: Alignment.center,
                      child: Text(
                       'Forgot Password?',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: Style().font_medium(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (){

                          },
                          child:   RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Enter your email address to continue.',
                                  style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: HexColor('#393838')),
                                ),
                              ],
                            ),
                          ),
                        )

                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Container(
                        height: 40,

                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 12),
                            fillColor: HexColor('ED8F2D'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: HexColor('ED8F2D')),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: HexColor('ED8F2D')),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: Style().font_regular(),
                              fontSize: 16,
                              color: Colors.grey,),
                            hintText: "Enter Email Id",
                          ),
                          style: TextStyle(
                            fontFamily: Style().font_regular(),
                            fontSize: 16,
                            color:  Colors.black,),
                          keyboardType: TextInputType.text,
                          controller: forgotPassEmailController,
                        )),
                    SizedBox(
                      height: 36,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: Text('SUBMIT'),
                        onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (_) => ForgotEmailSuccessWidget(),
                            );
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

  void _load() {
    widget._technicianLoginBloc.add(LoadTechnicianLoginEvent());
  }
}
