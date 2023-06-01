import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  Widget textDL({str, color, fontsize}) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: color,
          stops: const [0.0, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: Text(str,
          style: TextStyle(
            fontSize: fontsize,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Pub_Bg(),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
                width: ScreenUtil().setWidth(456),
                height: ScreenUtil().setHeight(876),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img/book_details_bg.png",),fit: BoxFit.fitHeight)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(242),
                      height: ScreenUtil().setHeight(282),
                      child: Image.network(
                        "https://th.bing.com/th/id/OIP.3P8oJs3Mo89Jr1I2I6Y5eQHaKU?w=129&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(29),
                    ),
                    textDL(
                        str: "《马克思主义哲学》",
                        fontsize: ScreenUtil().setSp(28),
                        color: [Color(0xffFFFFFF), Color(0xffA5A5A5)]),
                    textDL(
                        str: "作者：马克思",
                        fontsize: ScreenUtil().setSp(18),
                        color: [
                          Color.fromRGBO(255, 255, 255, 0.5),
                          Color.fromRGBO(255, 255, 255, 0.5),
                        ]),
                    textDL(
                        str: "教材类型：哲学宗教",
                        fontsize: ScreenUtil().setSp(18),
                        color: [
                          Color.fromRGBO(255, 255, 255, 0.5),
                          Color.fromRGBO(255, 255, 255, 0.5),
                        ]),
                    textDL(
                        str: "时间：1983-02-30",
                        fontsize: ScreenUtil().setSp(18),
                        color: [
                          Color.fromRGBO(255, 255, 255, 0.5),
                          Color.fromRGBO(255, 255, 255, 0.5),
                        ]),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(222),
                      height: ScreenUtil().setHeight(82),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(8)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(255, 255, 255, 0.4)),
                          color: const Color.fromRGBO(255, 255, 255, 0.12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "60%\n",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(28),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "学习进度",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(18),
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                    fontWeight: FontWeight.bold)),
                          ])),
                          Container(
                            width: ScreenUtil().setWidth(68),
                            height: ScreenUtil().setHeight(16),
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(260),
                      child: ListView(
                        
                       
                        children: [
                          Text(
                            "问感济总科存好质利却期它周千部道程结快感且千连书明白算严段它带位九区九且且所产可定法需离放才了建。或广因什样情热京交战通育复图影率象严直加与四思后并毛革备立高活理育万得争般格候体且认到划原许统转及很议儿段报装界期个满型等提向。离据打性红长眼计代率复步她法由方目话清进走况整命子往南心门特义非受状体把无非备六。无非农龙斗亲任图就三构场公共便织清风类温团影质作你拉回社则无级线料便圆活毛林次道带更连把。管色热有门亲族平技何候口里建成非它将直光然往的各委华中志政眼事图集备西起特称厂教六已元清己片质安法府拉王许历王治院果东。清里外果二数当间平身则按都色角色单了会历少为好列包话或断实米以国无准始研直化金料值面记变层科。化事参增运情家华身数族使结方始西点布来办叫干查较马精千千些得切放人光想必料。",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(18)),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(47),right: ScreenUtil().setWidth(30)),
              width: ScreenUtil().setWidth(900),
              height: ScreenUtil().setHeight(952),
              child: ListView.builder(
                
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.1),
                          Color.fromRGBO(255, 255, 255, 0.0)
                        ],
                      ),
                    ),
                    width: ScreenUtil().setWidth(320),
                    height: ScreenUtil().setHeight(152),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "第1章：章节名称最多显示",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(24)),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text("电子书",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)))),
                        Expanded(
                            flex: 2,
                            child: Text("电子书",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)))),
                        Expanded(
                            flex: 2,
                            child: Text("电子书",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20))))
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        
        ),
        
        Positioned(
                  top: ScreenUtil().setHeight(946),
                  left: ScreenUtil().setWidth(34),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(45),
                    width: ScreenUtil().setWidth(104),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Get.back();
                        },
                        child: Stack(
                          children: [Image.asset("assets/img/btn_back.png")],
                        ),
                      ),
                    ),
                  ))],
        
    ));
  }
}
