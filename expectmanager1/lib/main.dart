import 'package:flutter_localizations/flutter_localizations.dart';
import './common/component_index.dart';
import './ui/pages/page_index.dart';

import 'package:jpush_flutter/jpush_flutter.dart';
// import 'package:fake_alipay/fake_alipay.dart';
// import 'package:fake_wechat/fake_wechat.dart';

void main() => runApp(
      BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: AppPage(),
      ),
    );

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppPageState();
  }
}

class AppPageState extends State<AppPage> {
  Color _themeColor = Colours.blue_color;
  String debugLable = 'Unknown';
  final JPush jpush = new JPush();

  // static const bool _ALIPAY_USE_RSA2 = true;
  // static const String _ALIPAY_APPID = 'your alipay appId'; // 支付/登录
  // static const String _ALIPAY_PRIVATEKEY =
  //     'your alipay rsa private key(pkcs1/pkcs8)'; // 支付/登录

  // Alipay _alipay = Alipay()..registerApp();

  // StreamSubscription<AlipayResp> _pay;

  // static const String WECHAT_APPID = 'wx854345270316ce6e';
  // static const String WECHAT_APPSECRET = '';

  // Wechat _wechat = Wechat()..registerApp(appId: WECHAT_APPID);

  // StreamSubscription<WechatPayResp> _wxPay;

  @override
  void initState() {
    super.initState();
    _init();
    _initAsync();
    _initListener();
    initPlatformState();
    // _pay = _alipay.payResp().listen(_listenPay);
    // _wxPay = _wechat.payResp().listen(_listenWxPay);
  }

  void _init() {
    DioUtil.openDebug();
    Options options = DioUtil.getDefOptions();
    options.baseUrl = Constant.SERVER_ADDRESS;
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

  void _initAsync() async {
    await AppInstance.getInstance();
    if (!mounted) return;
    _loadLocale();
  }

  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      _loadLocale();
    });
  }

  void _loadLocale() {
    setState(() {
      String _colorKey = CommonHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }

  // void _listenPay(AlipayResp resp) {
  //   String content = 'pay: ${resp.resultStatus} - ${resp.result}';
  //   _showTips('支付', content);
  // }

  // void _listenWxPay(WechatPayResp resp) {
  //   String content = 'pay: ${resp.errorCode} ${resp.errorMsg}';
  //   _showTips('支付', content);
  // }

  // void _showTips(String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    // if (_pay != null) {
    //   _pay.cancel();
    // }
    // if (_wxPay != null) {
    //   _wxPay.cancel();
    // }
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print(rid);
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
        
      });
    });

    jpush.setup(
      appKey: "a46b5cd66da5fbf742769895",
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          setState(() {
            debugLable = "flutter onReceiveNotification: $message";
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLable = "flutter onReceiveMessage: $message";
          });
        },
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

// Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
//   return Center(
//     child: Text(
//       " ",
//       style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
//     ),
//   );
// }
  // @override
  // Widget build(BuildContext context) {
  // ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
  //   return getErrorWidget(context, errorDetails);
  // };
  Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
    return Center(
      child: Text(
        " ",
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return getErrorWidget(context, errorDetails);
    };
    return MaterialApp(
      debugShowCheckedModeBanner: AppConfig.isDebug,
      theme: ThemeData.light().copyWith(
        primaryColor: _themeColor,
        accentColor: _themeColor,
        indicatorColor: Colors.white,
        // primarySwatch: AppConfig.defaultColor,
        primaryTextTheme: TextTheme(
          display1: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) => SplashPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/splash': (BuildContext context) => SplashPage(),
        '/main': (BuildContext context) => MainPage(),
        '/diagnosecard': (BuildContext context) => CreditDiagnosePage(),
      },

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh'),
        const Locale('en', 'US'),
      ],

      // home: LoginPage(),
      // home: MainPage(),
      home: SplashPage(),
    );
  }
}
// }
