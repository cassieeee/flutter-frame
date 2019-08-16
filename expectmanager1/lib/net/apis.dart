class RequestApi {
  ///公共部分
  ///获取用户中心信息
  static const String UserInfo = "user/userInfo";

  /// 用户端
  /// 发送验证码
  static const String VALIDCODE = "user/sendCode";

  /// 用户登录或注册
  static const String UserSignIn = "user/signIn";

  /// 设置用户密码
  static const String SetUserPwd = "user/setPassword";

  /// 用户密码登录
  static const String LoginByPassword = "user/loginByPassword";

  /// 忘记密码
  static const String ForgetPwd = "User/forgetPassword";

  /// 修改手机号
  static const String ChangePhoneNum = "User/changePhone";

  /// 用户认证
  static const String UserCertificate = "user/certificate";

  ///获取首页卡片列表
  static const String GetCardInfo = "card/getCardList";

  ///更新账单
  static const String UpdateBill = "card/updateBill";

  ///获取可添加的银行列表
  static const String GetBankList = "card/getBankList";

  ///获取可添加的收款银行列表
  static const String GetReceiveBankList = "user/getReceiveBankList";

  ///获取收款银行列表
  static const String GetReceiveCardList = "user/getReceiveCardList";

  ///添加收款银行卡
  static const String AddReceiveCard = "user/addReceiveCard";

  ///移除收款银行卡
  static const String RemoveReceiveCard = "user/removeReceiveCard";

  ///获取诊断信用卡列表
  static const String GetDiagnoseCardList = "card/getDiagnoseCardList";

  ///添加信用卡
  static const String AddCreditCard = "card/addCard";

  ///卡片诊断
  static const String CardDiagnose = "card/diagnose";

  ///移除卡片
  static const String RemoveCard = "user/removeCard";

  ///发起托管
  static const String StartManager = "card/delegateCard";

  ///获取所有计划
  static const String GetAllPlanLists = "User/getPlanList";

  ///获取所有账单
  static const String GetAllBillLists = "user/getCardBill";

  ///获取用户中心信息
  static const String GetUserInfo = "user/userInfo";

  ///修改用户中心信息
  static const String modifyUserInfo = "user/modifyUser";

  ///获取我的管理师列表
  static const String GetMyMasterLists = "User/getMyMasterList";

  ///获取管理师下某个订单的卡片
  static const String GetMasterOrderCards = "User/getMasterOrderCard";

  ///设置查询参数
  static const String SetCardInput = "card/setCardInput";

  ///获取信用卡查询状态
  static const String GetCardStatus = "card/getCardStatus";

  ///修改密码
  static const String ModifyPassword = "user/modifyPassword";

  ///角色升级
  static const String UserUpgrade = "user/getUpgrade";

  ///用户余额明细
  static const String GetUserBanalanceDetail = "user/getBanlanceDetail";

  static String getPath({String path: '', int page, String resType}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
}
