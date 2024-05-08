import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/login/technician_login/index.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/app_constant.dart';
import 'package:vendor_app/utility/hex_color.dart';
import 'package:vendor_app/widgets/AppLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../utility/app_utility.dart';
import '../../../widgets/LogoutOverlay.dart';
import '../otp_verification/otp_verification_page.dart';

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
  SharedPreferences? sharedPreferences;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPassEmailController = TextEditingController();

  final _emailIdFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  FocusNode emailIdFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isApiCall = false;
  @override
  void initState() {
    super.initState();
    // EmailController.text ='singhsk39@gmail.com';
    // PasswordController.text ='use4Test';
    Future.delayed(const Duration(seconds: 2), () => 100,).then((value) {
      AppUtility.appUpdateDialog(context: context);
    });

    _load();

    emailIdFocusNode.addListener(() {
      if (!emailIdFocusNode.hasFocus) {
        _emailIdFormKey.currentState?.validate();
      } else {
        // _loginIdFormKey.currentState.reset();
      }
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        _passwordFormKey.currentState?.validate();
      } else {
        // _passwordFormKey.currentState.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianLoginBloc, TechnicianLoginState>(
        bloc: widget._technicianLoginBloc,
        listener: (context, currentState) {
          if (currentState is LoadingTechnicianLoginState) {
            isApiCall = true;
          }
          if (currentState is ErrorTechnicianLoginState) {
            isApiCall = false;
            AppUtility.showToast("Invalid email id & password.");
          }
          if (currentState is InTechnicianLoginState) {}
          if (currentState is TechnicianLoginSuccessState) {
            setLoginData(currentState.data);
            isApiCall = false;
            Navigator.pushNamed(context, '/dashboard');
          }
          if(currentState is ForgotPasswordSuccessState){
            isApiCall = false;
            Navigator.pushNamed(context, OtpVerificationPage.routeName,arguments: {'emailId':forgotPassEmailController.text});
          }
          if(currentState is TechnicianLoginErrorState){
            isApiCall = false;
            AppUtility.ShowToast(context, HexColor('ED8F2D').withOpacity(0.8),
                'Invalid UserName or Password', HexColor('#FFFFFF'), 4);
          }
        },
        builder: (
          BuildContext context,
          TechnicianLoginState currentState,
        ) {
          height = MediaQuery.of(context).size.height;
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
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height! * 0.20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width *0.25,
                              alignment: Alignment.center,
                              child: Image.asset('assets/images/app_logo.png'),
                            ),
                            const SizedBox(
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
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: LocaleKeys.LoginTechnicalLoginText.tr(),
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
                                // height: 40,
                                margin: const EdgeInsets.only(left: 24, right: 24),
                                child: Form(
                                  key: _emailIdFormKey,
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    decoration:  InputDecoration(
                                      contentPadding: const EdgeInsets.only(bottom: 12),
                                      fillColor: Colors.orangeAccent,
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orangeAccent),
                                      ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.redAccent),
                                        ),
                                        errorStyle: const TextStyle(color: Colors.redAccent),
                                      hintStyle: TextStyle(
                                        fontFamily: Style().font_regular(),
                                        fontSize: 16,
                                        color: Colors.grey,),
                                      hintText: LocaleKeys.LoginEnterEmailIdHint.tr(),
                                      labelText: 'Email Id',
                                      labelStyle: TextStyle(
                                        color: HexColor('ED8F2D')
                                      )
                                    ),
                                    style: TextStyle(
                                      fontFamily: Style().font_regular(),
                                      fontSize: 16,
                                      color:  Colors.black,),
                                    keyboardType: TextInputType.text,
                                    controller: emailController,
                                    focusNode: emailIdFocusNode,
                                    onFieldSubmitted: (val) {
                                      _emailIdFormKey.currentState
                                          ?.validate();
                                      FocusScope.of(context)
                                          .requestFocus(passwordFocusNode);
                                    },
                                    validator: (text) {
                                      bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(text.toString());
                                      if (text == null ||
                                          text.isEmpty) {
                                        return "Enter Email Id";
                                      }else if(!emailValid){
                                        return "Enter Valid Email Id";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                                // height: 40,
                                margin: const EdgeInsets.only(left: 24, right: 24),
                                child:  Form(
                                  key: _passwordFormKey,
                                  child: TextFormField(
                                    cursorColor: Colors.orangeAccent,
                                    decoration:  InputDecoration(
                                      contentPadding: const EdgeInsets.only(bottom: 12),
                                      fillColor: Colors.orangeAccent,
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color:Colors.orangeAccent),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orangeAccent),
                                      ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.redAccent),
                                        ),
                                      errorStyle: const TextStyle(color: Colors.redAccent),
                                      hintStyle: TextStyle(
                                        fontFamily: Style().font_regular(),
                                        fontSize: 16,
                                        color: Colors.grey,),
                                      hintText: LocaleKeys.LoginEnterPasswordHint.tr(),
                                      labelText: 'Password',
                                        labelStyle: TextStyle(
                                            color: HexColor('ED8F2D')
                                        )
                                    ),
                                    style: TextStyle(
                                      fontFamily: Style().font_regular(),
                                      fontSize: 16,
                                      color:  Colors.black,),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    validator: (text) {
                                      if (text == null ||
                                          text.isEmpty) {
                                        return "Password Empty.";
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (val){
                                      _passwordFormKey.currentState?.validate();
                                      if (_emailIdFormKey.currentState!.validate() &&
                                      _passwordFormKey.currentState!.validate()) {
                                        widget._technicianLoginBloc.add(
                                            TechnicianApiLoginEvent(
                                                emailController.text,
                                                passwordController.text));
                                      }
                                    },
                                  ),
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              margin: const EdgeInsets.only(top: 4, left: 24, right: 24),
                              child: ElevatedButton(
                                child: Text(LocaleKeys.LoginSignInBtn.tr(),style: const TextStyle(color: Colors.white),),
                                onPressed: () {
                                  if (_emailIdFormKey.currentState!.validate() &&
                                      _passwordFormKey.currentState!.validate()) {
                                    widget._technicianLoginBloc.add(
                                        TechnicianApiLoginEvent(
                                            emailController.text,
                                            passwordController.text));
                                  }
                                  },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor('ED8F2D'),
                                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(top: 10, left: 24, right: 24),
                                child: GestureDetector(
                                  onTap: (){
                                    forgotPasswordBottomSheet(context: context,height: (height!*0.3));
                                  },
                                  child:   RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: LocaleKeys.LoginForgotPasswordText.tr(),
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
                    Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10, left: 24, right: 24),
                        child: GestureDetector(
                          onTap: (){

                          },
                          child:   RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: LocaleKeys.LoginRegistrationNoteText.tr(),
                                  style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: HexColor('#393838').withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        )

                    ),
                  ],
                ),
                isApiCall ? const AppLoader() : Container(),
              ],
            )


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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : const Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                const EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(
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
                    const SizedBox(
                      height: 36,
                    ),
                    SizedBox(
                        height: 40,

                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 12),
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
                    const SizedBox(
                      height: 36,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: const Text('SUBMIT',style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          if(forgotPassEmailController.text.isEmpty){
                            AppUtility.showToast("Please enter email id.");
                          }else if(!AppUtility.validateEmail(forgotPassEmailController.text)){
                            AppUtility.showToast("Please enter valid email id.");
                          }else{
                            widget._technicianLoginBloc.add(
                                ForgotPasswordApiLoginEvent(
                                    forgotPassEmailController.text,
                                    ''));
                            Navigator.pop(context);
                          }


                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('ED8F2D'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
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

  setLoginData(userToken) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setString("userToken", userToken);
    AppConstant.userTokken = userToken;
  }
  void _load() {
    widget._technicianLoginBloc.add(LoadTechnicianLoginEvent());
  }
}
