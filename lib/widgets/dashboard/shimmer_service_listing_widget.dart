import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../utility/hex_color.dart';

class ShimmerServiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Shimmer.fromColors(
        baseColor: Colors.grey[300] !,
        highlightColor: Colors.grey[100] !,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 0, right: 16, left: 16),
                child:
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (_, __) =>SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 180.0,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 5,
                                shape: CircleBorder(
                                    side: BorderSide(width: 0, color: Theme
                                        .of(context)
                                        .colorScheme
                                        .primary)),
                                color: HexColor('#F1F9FE'),
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 18,
                                      margin: EdgeInsets.only(top: 8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                    ),
                                    const SizedBox(height: 16,),
                                    Container(
                                      width: 80,
                                      height: 18,

                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                    ),
                                  ],
                                )

                              ),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1.5,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 12,
                                        margin: EdgeInsets.only(top: 8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Colors.white,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                      Container(
                                        height: 12,
                                        margin: EdgeInsets.only(top: 8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Colors.white,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                    ],
                                  )

                              ),
                              const SizedBox(width: 16,),
                              Container(
                                width: 80,
                                height: 35,
                                margin: EdgeInsets.only(top: 6),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  )

              )
            ],
          ),
        ),
      );

  }
}
