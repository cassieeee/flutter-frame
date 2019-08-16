///用户登录
//发送验证码
class ValidCodeReq {
  String phone;
  int type;

  ValidCodeReq(this.phone, this.type);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'type': type,
      };
}

//用户登录或注册
class UserSignInReq {
  String phone;
  String code;

  UserSignInReq(this.phone, this.code);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'code': code,
      };
}

//用户首次设置密码
class UserSetPwdReq {
  String token;
  String password;

  UserSetPwdReq(this.token, this.password);

  Map<String, dynamic> toJson() => {
        'token': token,
        'password': password,
      };
}

//用户密码登录
class UserLoginByPwd {
  String phone;
  String password;

  UserLoginByPwd(this.phone, this.password);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
      };
}

//用户找回密码
class ForgetPwdReq {
  String phone;
  String password;
  String code;

  ForgetPwdReq(this.phone, this.password, this.code);

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
        'code': code,
      };
}

//获取首页卡片列表信息
class CreditCardInfoReq {
  String token;
  CreditCardInfoReq(this.token);

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}

//更新账单
class UpdateBillReq {
  String token;
  num cardInstId;
  UpdateBillReq(this.token, this.cardInstId);

  Map<String, dynamic> toJson() => {
        'token': token,
        'cardInstId': cardInstId,
      };
}

//获取可添加的银行列表
class GetBankAddListReq {
  String token;
  GetBankAddListReq(this.token);
  Map<String, dynamic> toJson() => {
        'token': token,
      };
}

//添加信用卡
class AddCreditCardReq {
  String token;
  String user;
  String password;
  num banCode;
  int delegateType;
  num toUid;

  AddCreditCardReq(
    this.token,
    this.user,
    this.password,
    this.banCode,
    this.delegateType,
    this.toUid,
  );

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user,
        'password': password,
        'banCode': banCode,
        'delegateType': delegateType,
        "toUid": toUid
      };
}

//卡片诊断
class CardDiagnoseReq {
  String token;
  String cardInstId;
  String squpdtime;
  String sqlimit;

  CardDiagnoseReq(
    this.token,
    this.cardInstId,
    this.squpdtime,
    this.sqlimit,
  );

  Map<String, dynamic> toJson() => {
        'token': token,
        'cardInstId': cardInstId,
        'squpdtime': squpdtime,
        'sqlimit': sqlimit,
      };
}

//移除卡片
class RemoveCardReq {
  String token;
  num cardInstId;

  RemoveCardReq(
    this.token,
    this.cardInstId,
  );

  Map<String, dynamic> toJson() => {
        'token': token,
        'cardInstId': cardInstId,
      };
}

//获取所有计划列表
class AllPlanListsReq {
  String token;
  int page;
  String condition;
  AllPlanListsReq(this.token, this.page, this.condition);

  Map<String, dynamic> toJson() =>
      {'token': token, 'page': page, 'condition': condition};
}

//计划列表condition
class PlanConditions {
  num flag;
  String startTime;
  String endTime;
  num delegateType;
  num planType;
  num userId;
  PlanConditions(this.flag, this.startTime, this.endTime, this.delegateType,
      this.planType, this.userId);

  Map<String, dynamic> toJson() => {
        'flag': flag,
        'startTime': startTime,
        'endTime': endTime,
        'delegateType': delegateType,
        'planType': planType,
        'userId': userId
      };
}
