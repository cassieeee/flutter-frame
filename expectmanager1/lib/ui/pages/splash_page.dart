import 'package:flutter/painting.dart';

import 'page_index.dart';
import '../../common/component_index.dart';
// import 'package:rxdart/rxdart.dart';

import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  List<String> _guideList;

  List<Widget> _bannerList = new List();

  int _status = 0;
  int _count = 3;

  SplashModel _splashModel;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    await AppInstance.getInstance();

    if (Screen.isIPhoneX) {
      _guideList = [
        'assets/images/splash/intro1_x.png',
        'assets/images/splash/intro2_x.png',
        'assets/images/splash/intro3_x.png',
      ];
    } else {
      _guideList = [
        'assets/images/splash/intro1.png',
        'assets/images/splash/intro2.png',
        'assets/images/splash/intro3.png',
      ];
    }

    // _loadSplashData();

    // Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
    // AppInstance.putBool(Constant.KEY_GUIDE, false);
    // if (AppInstance.getBool(Constant.KEY_GUIDE) != true &&
    //     ObjectUtil.isNotEmpty(_guideList)) {
    //   AppInstance.putBool(Constant.KEY_GUIDE, true);
    //   _initBanner();
    // }
    // else
    // {
    //   _initSplash();
    // }
    // });
  }

  void _loadSplashData() {
    _splashModel = CommonHelper.getSplashModel();
    if (_splashModel != null) {
      setState(() {});
    }
    HttpUtils httpUtil = new HttpUtils();
    httpUtil.getSplash().then((model) {
      if (!ObjectUtil.isEmpty(model.imgUrl)) {
        if (_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
          AppInstance.putObject(Constant.KEY_SPLASH_MODEL, model);
          setState(() {
            _splashModel = model;
          });
        }
      } else {
        AppInstance.putObject(Constant.KEY_SPLASH_MODEL, null);
      }
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 50.0 * Screen.screenRate),
                child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: Container(
                    width: 130 * Screen.screenRate,
                    height: 44 * Screen.screenRate,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colours.white_color,
                      border: Border.all(
                        color: Colours.blue_color,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colours.blue_color,
                          fontSize: 16.0 * Screen.screenRate,
                          fontWeight: FontWeights.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _initSplash() {
    if (_splashModel == null) {
      _goMain();
    } else {
      _doCountDown();
    }
  }

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    if (AppInstance.isLogin) {
      loginSwitch();
    } else {
      NavigatorUtil.pushPage(context, LoginPage());
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => LoginPage(),
      //   ),
      // );
    }
  }

  void loginSwitch() async {
    await PermissionHandler().requestPermissions([PermissionGroup.contacts]);

    int type = int.tryParse(AppInstance.currentUser.roleType);

    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    String themeColor =  "usercolor";
    AppInstance.putString(Constant.KEY_THEME_COLOR, themeColor);
    bloc.sendAppEvent(1);

    Widget mainPage = MainPage();

    // AppInstance.initContext = context;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: "MainPage"),
        builder: (BuildContext context) => mainPage,
      ),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildSplashBg() {
    if (_timerUtil == null) {
      _timerUtil = new TimerUtil(mTotalTime: 2 * 1000);
      _timerUtil.setOnTimerTickCallback((int tick) {
        double _tick = tick / 1000;
        setState(() {
          _count = _tick.toInt();
        });
        if (_tick == 0) {
          if (AppInstance.getBool(Constant.KEY_GUIDE) != true &&
              ObjectUtil.isNotEmpty(_guideList)) {
            AppInstance.putBool(Constant.KEY_GUIDE, true);
            _initBanner();
          } else {
            _goMain();
          }
          if (_timerUtil != null) _timerUtil.cancel();
        }
      });
      _timerUtil.startCountDown();
    }

    if (Screen.isIPhoneX) {
      return new Image.asset(
        'assets/images/splash/splash_bg_x.png',
        width: double.infinity,
        fit: BoxFit.fill,
        height: double.infinity,
      );
    }
    return new Image.asset(
      'assets/images/splash/splash_bg.png',
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  // Widget _buildAdWidget() {
  //   if (_splashModel == null) {
  //     return new Container(
  //       height: 0.0,
  //     );
  //   }
  //   return new Offstage(
  //     offstage: !(_status == 1),
  //     child: new InkWell(
  //       onTap: () {
  //         if (ObjectUtil.isEmpty(_splashModel.url)) return;
  //         _goMain();
  //         // NavigatorUtil.pushWeb(context,
  //         //     title: _splashModel.title, url: _splashModel.url);
  //       },
  //       child: new Container(
  //         alignment: Alignment.center,
  //         child: new CachedNetworkImage(
  //           width: double.infinity,
  //           height: double.infinity,
  //           fit: BoxFit.fill,
  //           imageUrl: _splashModel.imgUrl,
  //           placeholder: (context, url) => _buildSplashBg(),
  //           errorWidget: (context, url, error) => _buildSplashBg(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          new Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
                ? new Container()
                : new Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                      radius: 4.0,
                      padding: EdgeInsets.only(
                        bottom: 25.0 * Screen.screenRate,
                      ),
                      itemColor: Colours.text_placehold2,
                      itemActiveColor: Colours.white_color,
                    ),
                    children: _bannerList),
          ),
          // _buildAdWidget(),
          // new Offstage(
          //   offstage: !(_status == 1),
          //   child: new Container(
          //     alignment: Alignment.bottomRight,
          //     margin: EdgeInsets.all(20.0),
          //     child: InkWell(
          //       onTap: () {
          //         _goMain();
          //       },
          //       child: new Container(
          //           padding: EdgeInsets.all(12.0),
          //           child: new Text(
          //             '跳过 $_count',
          //             style: new TextStyle(fontSize: 14.0, color: Colors.white),
          //           ),
          //           decoration: new BoxDecoration(
          //               color: Color(0x66000000),
          //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //               border: new Border.all(
          //                   width: 0.33, color: Colours.divider_color))),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel。
  }
}
