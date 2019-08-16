import '../common/component_index.dart';

import 'dart:io';
import 'package:dio/dio.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class HttpUtils {
  static const String baseUrl = 'http://www.shuqi.com/';

  static Dio createDio() {
    var options = Options(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
      contentType: ContentType.json,
    );
    return Dio(options);
  }

  static Future<dynamic> get({String action, Map params}) async {
    // return HttpUtils.mock(action: action, params: params);

    var dio = HttpUtils.createDio();
    Response<Map> response = await dio.get(action, data: params);
    var data = response.data['data'];
    print(data);

    return data;
  }

  static Future<dynamic> post({String action, Map params}) async {
    // return HttpUtils.mock(action: action, params: params);

    var dio = HttpUtils.createDio();
    Response<Map> response = await dio.post(action, data: params);
    var data = response.data['data'];
    print(data);

    return data;
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }

  //模拟网络请求数据
  
  Future<SplashModel> getSplash() {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new SplashModel(
        title: 'Flutter 常用工具类库',
        content: 'Flutter 常用工具类库',
        url: 'https://www.jianshu.com/p/425a7ff9d66e',
        imgUrl:
            'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png',
      );
    });
  }

  Future<VersionModel> getVersion() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new VersionModel(
        title: '有新版本v0.1.2，去更新吧！',
        content: '',
        url:
            'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppStore/flutter_wanandroid_new.apk',
        version: AppConfig.version,
      );
    });
  }
}
