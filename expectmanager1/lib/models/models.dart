import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:youxinbao/common/component_index.dart';

Map statusMap = {
  '1': '待消费', //待消费（消费计划）
  '2': '待还款', //待还款（还款计划）
  '3': '待确认', //待确认（还款计划）
  '4': '完成',
  '-1': '问题订单',
};

///通用模型
class LanguageModel {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageModel(this.titleId, this.languageCode, this.countryCode,
      {this.isSelected: false});

  LanguageModel.fromJson(Map<String, dynamic> json)
      : titleId = json['titleId'],
        languageCode = json['languageCode'],
        countryCode = json['countryCode'],
        isSelected = json['isSelected'];

  Map<String, dynamic> toJson() => {
        'titleId': titleId,
        'languageCode': languageCode,
        'countryCode': countryCode,
        'isSelected': isSelected,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"titleId\":\"$titleId\"");
    sb.write(",\"languageCode\":\"$languageCode\"");
    sb.write(",\"countryCode\":\"$countryCode\"");
    sb.write('}');
    return sb.toString();
  }
}

class SplashModel {
  String title;
  String content;
  String url;
  String imgUrl;

  SplashModel({this.title, this.content, this.url, this.imgUrl});

  SplashModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'imgUrl': imgUrl,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write('}');
    return sb.toString();
  }
}

class VersionModel {
  String title;
  String content;
  String url;
  String version;

  VersionModel({this.title, this.content, this.url, this.version});

  VersionModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        version = json['version'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'version': version,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"version\":\"$version\"");
    sb.write('}');
    return sb.toString();
  }
}

//获取用户中心信息
class UserInfoModel {
  var name;
  String sex;
  String icon;
  String provinces;
  String city;
  String birthDay;
  String createTime;
  int isCertification;
  int uid;
  var phone;
  int roleType;
  num myAuthMoney;
  num remainAuthMoney;
  num withdraw;
  num workAge;
  num money;
  num balance;
  num todayIncome;
  num curMonthIncome;
  num totalIncome;
  num unavailable;

  UserInfoModel.fromJson(Map json) {
    name = json['name'];
    sex = json['sex'];
    icon = json['icon'];
    provinces = json['provinces'];
    city = json['city'];
    birthDay = json['birthDay'];
    createTime = json['createTime'];
    isCertification = json['isCertification'];
    uid = json['uid'];
    phone = json['phone'];
    roleType = json['roleType'];
    myAuthMoney = json['myAuthMoney'];
    remainAuthMoney = json['remainAuthMoney'];
    withdraw = json['withdraw'];
    workAge = json['workAge'];
    money = json['money'];
    balance = json['balance'];
    totalIncome = json['totalIncome'];
    curMonthIncome = json['curMonthIncome'];
    todayIncome = json['todayIncome'];
    unavailable = json['unavailable'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sex': sex,
      'icon': icon,
      'provinces': provinces,
      'city': city,
      'birthDay': birthDay,
      'createTime': createTime,
      'isCertification': isCertification,
      'uid': uid,
      'phone': phone,
      'roleType': roleType,
      'name': name,
      'myAuthMoney': myAuthMoney,
      'remainAuthMoney': remainAuthMoney,
      'withdraw': withdraw,
      'workAge': workAge,
      'money': money,
      'balance': balance,
      'totalIncome': totalIncome,
      'curMonthIncome': curMonthIncome,
      'todayIncome': todayIncome,
      'unavailable': unavailable,
    };
  }
}

///用户端
//用户模型
class UserModel {
  String token;
  int id;
  var nickname;
  String avatarUrl;
  String roleType = "0";
  String isCertification;
  String isFirstLogin;
  List privilegeList;

  UserModel.fromJson(Map json) {
    token = json['token'];
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatar'];
    roleType = json['roleType'].toString();
    isFirstLogin = json['isFirstLogin'].toString();
    isCertification = json['isCertification'] != null
        ? json['isCertification'].toString()
        : "0";
    privilegeList = json['privilegeList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'nickname': nickname,
      'avatar': avatarUrl,
      'roleType': roleType,
      'isFirstLogin': isFirstLogin,
      'isCertification': isCertification,
      'privilegeList': privilegeList
    };
  }
}

//首页数据模型
class CardInfoModel {
  List<dynamic> cardList;
  num cardCount;
  num totalAccLimit;
  num totalAccCost;
  num totalAccLimitRepay;
  num totalUsableMoney;
  num totalDelegateMoney;
  num actualMoney;
  num delegateCount;
  num undelegateCount;

  CardInfoModel(this.cardCount);

  CardInfoModel.fromJson(Map json) {
    cardList = json["cardList"].map((value) {
      return CardItemModel.fromJson(value);
    }).toList();
    cardCount = json['cardCount'];
    totalAccLimit = json['totalAccLimit'];
    totalAccCost = json['totalAccCost'];
    totalAccLimitRepay = json['totalAccLimitRepay'];
    totalUsableMoney = json['totalUsableMoney'];
    totalDelegateMoney = json['totalDelegateMoney'];
    actualMoney = json['actualMoney'];
    delegateCount = json['delegateCount'];
    undelegateCount = json['undelegateCount'];
  }
}

//首页卡片列表模型
class CardItemModel {
  num id;
  num bankId;
  num userId;
  var name;
  dynamic cardId;
  var cardName;
  var bankName;
  num accDay;
  num accPayday;
  num accLimit;
  num accLimitCost;
  num accLimitRepay;
  num usableMoney;
  num payStatus;
  num credit;
  num delegate;
  String updateTime;
  String createTime;
  num status;
  num isDelegated;
  num delegateType;
  var masterName;
  num delegateMoney;
  String icon;
  num isDiagnose;
  var nearAccPayday;
  var nearAccDay;
  num nearAccDays;
  num nearAccPaydays;
  num bankCode;

  CardItemModel();

  CardItemModel.fromJson(Map json) {
    id = json['id'];
    bankId = json['bankId'];
    userId = json['userId'];
    name = json['name'];
    cardId = json['cardId'];
    cardName = json['cardName'];
    bankName = json['bankName'];
    accDay = json['accDay'];
    accPayday = json['accPayday'];
    accLimit = json['accLimit'];
    accLimitCost = json['accLimitCost'];
    accLimitRepay = json['accLimitRepay'];
    usableMoney = json['usableMoney'];
    payStatus = json['payStatus'];
    credit = json['credit'];
    delegate = json['delegate'];
    updateTime = json['updateTime'];
    createTime = json['createTime'];
    status = json['status'];
    isDelegated = json['isDelegated'];
    delegateType = json['delegateType'];
    masterName = json['masterName'];
    delegateMoney = json['delegateMoney'];
    icon = json['icon'];
    isDiagnose = json['isDiagnose'];
    nearAccPayday = json['nearAccPayday'];
    nearAccDay = json['nearAccDay'];
    nearAccDays = json['nearAccDays'];
    nearAccPaydays = json['nearAccPaydays'];
    bankCode = json['bankCode'];
  }
}

//可添加卡片列表项
class AddCardListItem {
  num id;
  num code;
  String cn;
  String icon;
  num sort;
  AddCardListItem.fromJson(Map json) {
    id = json['id'];
    code = json['code'];
    cn = json['cn'];
    icon = json['icon'];
    sort = json['sort'];
  }
}

//获取诊断信用卡项
class DiagnoseCardItem {
  num id;
  String bankName;
  num accLimit;
  dynamic cardId;
  num isDiagnose;
  String lastTime;
  String color;
  String icon;

  DiagnoseCardItem();

  DiagnoseCardItem.fromJson(Map json) {
    id = json['id'];
    bankName = json['bankName'];
    accLimit = json['accLimit'];
    cardId = json['cardId'];
    isDiagnose = json['isDiagnose'];
    lastTime = json['lastTime'];
    color = json['color'];
    icon = json['icon'];
  }
}

//获取诊断信用卡列表信息
class DiagnoseCardInfo {
  List<dynamic> cardList;
  num totalAccLimit;
  num totalCardCount;
  String icon;
  num account;

  DiagnoseCardInfo.fromJson(Map json) {
    cardList = json["cardList"].map((value) {
      return DiagnoseCardItem.fromJson(value);
    }).toList();
    totalAccLimit = json['totalAccLimit'];
    totalCardCount = json['totalCardCount'];
    icon = json['icon'];
    account = json['account'];
  }
}
