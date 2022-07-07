import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/app_themes/custom_color_theme.dart';
import 'package:vendor_app/modules/login/otp_verification/index.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../style/style.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/success_password_fetch.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    required OtpVerificationBloc otpVerificationBloc,
    Key? key,
  })  : _otpVerificationBloc = otpVerificationBloc,
        super(key: key);

  final OtpVerificationBloc _otpVerificationBloc;

  @override
  OtpVerificationScreenState createState() {
    return OtpVerificationScreenState();
  }
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  OtpVerificationScreenState();

  bool isApiCall = false;
  TextEditingController _OtpController = TextEditingController();
  SharedPreferences? sharedPreferences;
  String? mobileNo = '';
  Timer? _timer;
  int sec = 30;
  String? resendtext = '';
  bool? canCheckBiometrics;
  String emailId="";

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (sec == 0) {
          if (mounted) {
            setState(() {
              resendtext = '${LocaleKeys.OtpVerificationResendOtpLbl.tr()}';
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              sec--;
              resendtext =
              '${LocaleKeys.OtpVerificationResendOtpInLbl.tr()} ${sec} ${LocaleKeys.OtpVerificationSecondLbl.tr()}';
            });
          }
        }
      },
    );
  }
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
    return BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        bloc: widget._otpVerificationBloc,
        listener: (
            BuildContext context,
            OtpVerificationState currentState,
            ) async {
          if (currentState is UnOtpVerificationState) {
            isApiCall = false;
          }
          if (currentState is ErrorOtpVerificationState) {
            FocusScope.of(context).unfocus();
            isApiCall = false;
            AppUtility.ShowToast(context, HexColor('AFE1C3'),
                '${currentState.errorMessage}', HexColor('0B600B'), 4);
          }


          if (currentState is InOtpVerificationState) {
            isApiCall = false;
          }
          if (currentState is LoadingOtpVerificationState) {
            isApiCall = true;
          } if (currentState is SuccessOtpVerificationState) {
            isApiCall = false;
            Navigator.pushNamed(context, SuccessPasswordPage.routeName,arguments: {"password":currentState.password});

          }

        },
        builder: (
            BuildContext context,
            OtpVerificationState currentState,
            ) {
          final arguments = ModalRoute.of(context)?.settings.arguments as Map;
          emailId = arguments['emailId'];
          return WillPopScope(
            onWillPop: () async{
              _timer?.cancel();
              Navigator.pop(context, true);
              return true;
            },
            child: Container(
              child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              _timer?.cancel();
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios,size: 24,)
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                            child: Text(
                              LocaleKeys.OtpVerificationLbl.tr(),
                              style: TextStyle(
                                  color:
                                  Theme.of(context).colorScheme.blackColor3,
                                  fontSize: 24.0,
                                  fontFamily: Style().font_medium()),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60, right: 24, left: 24),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                top: 54,
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                        '${LocaleKeys.OtpVerificationEnteredOtpSentToLbl.tr()}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .blackColor3,
                                          fontSize: 18.0,
                                          fontFamily: Style().font_medium(),
                                        )),
                                  ],
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 24, right: 24, top: 26),
                                child: PinCodeTextField(
                                length: 6,
                                // obscureText: true,
                                // obscuringCharacter: '*',
                                autoFocus: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.transparent,
                                  inactiveColor: HexColor('CED3DB'),
                                  activeColor: HexColor('CED3DB'),
                                  inactiveFillColor: Colors.transparent,
                                  selectedFillColor: Colors.transparent,
                                ),
                                // animationDuration: Duration(milliseconds: 300),
                                // backgroundColor: Colors.blue.shade50,
                                enableActiveFill: true,

                                // errorAnimationController: errorController,
                                controller: _OtpController,
                                inputFormatters: [
                                  new FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                keyboardType: TextInputType.number,
                                textStyle: TextStyle(
                                    fontFamily: Style().font_regular(),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .blackColor3),
                                onCompleted: (v) {
                                  setState(() {
                                    if (_OtpController.text.length == 0) {
                                    } else {
                                      widget._otpVerificationBloc.add(GetOtpApiLoginEvent(emailId,_OtpController.text.toString()));
                                  }});
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // currentText = value;
                                  });
                                },

                                beforeTextPaste: (text) {
                                  return true;
                                },
                                appContext: context,
                              )),
                        ],
                      ),
                    ),
                    isApiCall ? AppLoader() : Container(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _load() {
    widget._otpVerificationBloc.add(LoadOtpVerificationEvent());
  }
}
