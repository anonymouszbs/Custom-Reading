import 'dart:ui';

import 'package:ceshi1/widgets/animation/stepwidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HonorPage extends StatelessWidget {
  const HonorPage({super.key});

  Widget textDL({txt, size, color}) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: color,
          stops: [0.0, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: txt,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(size),
                fontWeight: FontWeight.bold)),
      ])),
    );
  }

  headimg(size) {
    return SizedBox(
      height: size,
      width: size,
      child: const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50,
        backgroundImage: AssetImage("assets/img/head.png"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(34.h),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 55,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: 534.w,
                            height: 469.h,
                            // padding: EdgeInsets.only(top: 16.h,left: 24.w),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/img/download_bg.png")),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 24, top: 16, bottom: 16),
                                      child: textDL(
                                          txt: "任务学习达人榜",
                                          size: 28.sp,
                                          color: [
                                            Color.fromRGBO(214, 171, 91, 1),
                                            Color.fromRGBO(240, 223, 163, 1),
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 46.w,
                                      height: 35.h,
                                      child: Image.asset(
                                        "assets/img/TOP.png",
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 486.w,
                                  height: 160.h,
                                  decoration: const BoxDecoration(
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.05),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 80.w,
                                        height: 80.h,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                headimg(40.w),
                                                textDL(
                                                    txt: "王富贵",
                                                    size: 18.sp,
                                                    color: [
                                                      Colors.white,
                                                      Colors.white
                                                    ])
                                              ],
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: -1,
                                                child: Image.asset(
                                                  "assets/img/rank01.png",
                                                  fit: BoxFit.cover,
                                                  height: 30.h,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "100%\n",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24.sp)),
                                                TextSpan(
                                                    text: "计划任务完成",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16.sp))
                                              ])),
                                          SizedBox(
                                            width: 44.w,
                                          ),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "8天\n",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24.sp)),
                                                TextSpan(
                                                    text: "计划任务用时",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16.sp))
                                              ]))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 24.w, top: 8.h),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 239.w,
                                        height: 119.h,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.05),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    headimg(40.w),
                                                    textDL(
                                                        txt: "王富贵",
                                                        size: 18.sp,
                                                        color: [
                                                          Colors.white,
                                                          Colors.white
                                                        ])
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 16.w),
                                                  child: Image.asset(
                                                    "assets/img/rank02.png",
                                                    fit: BoxFit.cover,
                                                    height: 34.h,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "100%\n",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24.sp)),
                                                      TextSpan(
                                                          text: "计划任务完成",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16.sp))
                                                    ])),
                                                SizedBox(
                                                  width: 24.w,
                                                ),
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "8天\n",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24.sp)),
                                                      TextSpan(
                                                          text: "计划任务用时",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16.sp))
                                                    ]))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 239.w,
                                        height: 119.h,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.05),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    headimg(40.w),
                                                    textDL(
                                                        txt: "王富贵",
                                                        size: 18.sp,
                                                        color: [
                                                          Colors.white,
                                                          Colors.white
                                                        ])
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 16.w),
                                                  child: Image.asset(
                                                    "assets/img/rank03.png",
                                                    fit: BoxFit.cover,
                                                    height: 34.h,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "100%\n",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24.sp)),
                                                      TextSpan(
                                                          text: "计划任务完成",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16.sp))
                                                    ])),
                                                SizedBox(
                                                  width: 24.w,
                                                ),
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "8天\n",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24.sp)),
                                                      TextSpan(
                                                          text: "计划任务用时",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16.sp))
                                                    ]))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    textDL(
                                        txt: "04",
                                        size: 24.sp,
                                        color: [Colors.white, Colors.white]),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Row(
                                      children: [
                                        headimg(20.sp),
                                        textDL(txt: "王大锤", size: 24.sp, color: [
                                          Colors.white,
                                          Colors.white
                                        ]),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 180.w,
                                    ),
                                    textDL(
                                        txt: "计划任务完成 80%",
                                        size: 14.sp,
                                        color: [Colors.grey, Colors.grey]),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    textDL(
                                        txt: "计划任务用时 10天",
                                        size: 14.sp,
                                        color: [Colors.grey, Colors.grey]),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    textDL(
                                        txt: "04",
                                        size: 24.sp,
                                        color: [Colors.white, Colors.white]),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Row(
                                      children: [
                                        headimg(20.sp),
                                        textDL(txt: "王大锤", size: 24.sp, color: [
                                          Colors.white,
                                          Colors.white
                                        ]),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 180.w,
                                    ),
                                    textDL(
                                        txt: "计划任务完成 80%",
                                        size: 14.sp,
                                        color: [Colors.grey, Colors.grey]),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    textDL(
                                        txt: "计划任务用时 10天",
                                        size: 14.sp,
                                        color: [Colors.grey, Colors.grey]),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    Container(
                      width: 534.w,
                      height: 469.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/download_bg.png")),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0),
                            Color.fromRGBO(255, 255, 255, 0.12)
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                              width: 534.w,
                              height: 469.h,
                              // padding: EdgeInsets.only(top: 16.h,left: 24.w),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/download_bg.png")),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 24, top: 16, bottom: 16),
                                        child: textDL(
                                            txt: "任务学习达人榜",
                                            size: 28.sp,
                                            color: [
                                              Color.fromRGBO(255, 255, 255, 1),
                                              Color.fromRGBO(165, 165, 165, 1),
                                            ]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 486.w,
                                    height: 160.h,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.05),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/img/rank01.png",
                                              fit: BoxFit.cover,
                                              height: 50.h,
                                            ),
                                            SizedBox(
                                              width: 42.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                headimg(40.w),
                                                textDL(
                                                    txt: "王富贵",
                                                    size: 18.sp,
                                                    color: [
                                                      Colors.white,
                                                      Colors.white
                                                    ])
                                              ],
                                            ),
                                          ],
                                        ),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "99988\n",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp)),
                                              TextSpan(
                                                  text: "自学课程数量",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16.sp))
                                            ]))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 24.w, top: 8.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 239.w,
                                          height: 119.h,
                                          decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.05),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 12.w,
                                                      ),
                                                      headimg(40.w),
                                                      textDL(
                                                          txt: "王富贵",
                                                          size: 18.sp,
                                                          color: [
                                                            Colors.white,
                                                            Colors.white
                                                          ])
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 16.w),
                                                    child: Image.asset(
                                                      "assets/img/rank02.png",
                                                      fit: BoxFit.cover,
                                                      height: 34.h,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "1000\n",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24.sp)),
                                                    TextSpan(
                                                        text: "自学课程数量",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16.sp))
                                                  ]))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 239.w,
                                          height: 119.h,
                                          decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.05),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 12.w,
                                                      ),
                                                      headimg(40.w),
                                                      textDL(
                                                          txt: "王富贵",
                                                          size: 18.sp,
                                                          color: [
                                                            Colors.white,
                                                            Colors.white
                                                          ])
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 16.w),
                                                    child: Image.asset(
                                                      "assets/img/rank03.png",
                                                      fit: BoxFit.cover,
                                                      height: 34.h,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "99999\n",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24.sp)),
                                                    TextSpan(
                                                        text: "自学课程数量",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16.sp))
                                                  ]))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      textDL(
                                          txt: "04",
                                          size: 24.sp,
                                          color: [Colors.white, Colors.white]),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Row(
                                        children: [
                                          headimg(20.sp),
                                          textDL(
                                              txt: "王大锤",
                                              size: 24.sp,
                                              color: [
                                                Colors.white,
                                                Colors.white
                                              ]),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 280.w,
                                      ),
                                      textDL(
                                          txt: "自学课程数量 99",
                                          size: 14.sp,
                                          color: [Colors.grey, Colors.grey]),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      textDL(
                                          txt: "04",
                                          size: 24.sp,
                                          color: [Colors.white, Colors.white]),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Row(
                                        children: [
                                          headimg(20.sp),
                                          textDL(
                                              txt: "王二锤",
                                              size: 24.sp,
                                              color: [
                                                Colors.white,
                                                Colors.white
                                              ]),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 280.w,
                                      ),
                                      textDL(
                                          txt: "自学课程数量 99",
                                          size: 14.sp,
                                          color: [Colors.grey, Colors.grey]),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 40,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/honor_bg.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 24.w, top: 16.h),
                      child: textDL(
                          txt: "最热书籍榜",
                          size: 28.sp,
                          color: [Colors.white, Colors.white]),
                    ),
                    SizedBox(
                      width: 541.w,
                      height: 900.h,
                      child: ListView.separated(
                          padding: EdgeInsets.only(
                              left: 26.w, right: 26.w, bottom: 26.h, top: 26.h),
                          itemBuilder: (context, index) {
                            final subwidget;
                            if (index == 0) {
                              subwidget = Image.asset(
                                "assets/img/rank01.png",
                                fit: BoxFit.cover,
                                height: 34.h,
                              );
                            } else if (index == 1) {
                              subwidget = Image.asset(
                                "assets/img/rank02.png",
                                fit: BoxFit.cover,
                                height: 34.h,
                              );
                            } else if (index == 2) {
                              subwidget = Image.asset(
                                "assets/img/rank03.png",
                                fit: BoxFit.cover,
                                height: 34.h,
                              );
                            }else{
                              subwidget = Container(
                                width: 44.w,
                                height: 28.h,
                                alignment: Alignment.center,
                                color: Color.fromRGBO(255, 0, 19, 1).withOpacity(0.3),
                                child: textDL(size: 24.sp,txt:index<10?"0$index":"$index",color: [Colors.white,Colors.white]),
                              );
                            }
                            return Container(
                              width: 464.w,
                              height: 184.h,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color.fromRGBO(255, 255, 255, 0.15),
                                    Color.fromRGBO(255, 255, 255, 0.2)
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 120.w,
                                          height: 160.h,
                                          child: Image.asset("assets/img/bookcover.jpg"),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textDL(
                                                txt: "书籍名称",
                                                size: 28.sp,
                                                color: [
                                                  Colors.white,
                                                  Colors.white
                                                ]),
                                            textDL(
                                                txt: "书籍名称",
                                                size: 24.sp,
                                                color: [
                                                  Colors.grey,
                                                  Colors.grey
                                                ]),
                                            Row(
                                              children: [
                                                textDL(
                                                    txt: "我的进度 ",
                                                    size: 28.sp,
                                                    color: [
                                                      Colors.grey,
                                                      Colors.grey
                                                    ]),
                                                StepWidget(progress: 60)
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      child: Container(
                                    alignment: Alignment.topRight,
                                    child: subwidget,
                                  ))
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, int) {
                            return Divider(
                              height: 10.h,
                            );
                          },
                          itemCount: 10),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
