import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        // color: Colors.black.withOpacity(1.0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Container(
                  // optional
                  // grey-ish filter to the background
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            Center(
              child: Container(
                  height: 100,
                  child: Lottie.asset('assets/lottie_anim/reach_location.json')),
            ),
          ],
        ));
  }
}

// class _HSLLoaderState extends State<HSLLoaderTest> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       decoration:  BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//           border: Border.all(color: HexColor("#E8E8E8"), width: 1.0)),
//       alignment: Alignment.bottomCenter,
//       margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.30),
//       padding: EdgeInsets.all(20.0),
//       height: MediaQuery.of(context).size.height * 0.14,
//
//       // height: 80,
//       child: Center(
//         child: Image.asset(
//           "assets/icons/hdfc_loader.gif",
//           height: 50.0,
//           width: 50.0,
//         ),
//       )
//       // Row(
//       //   mainAxisAlignment: MainAxisAlignment.start,
//       //   children: [
//       //     CircularProgressIndicator(),
//       //     SizedBox(width:15),
//       //     Expanded(
//       //       child: Container(
//       //           child: Text(widget.message,
//       //         textAlign: TextAlign.left,
//       //             style: TextStyle(
//       //                 fontFamily: Style().helvetica_light(),
//       //                 fontSize: 16.0,
//       //                 backgroundColor: Colors.white,
//       //               ),)),
//       //     )
//       //   ],
//       // ),
//     );
//   }
// }

