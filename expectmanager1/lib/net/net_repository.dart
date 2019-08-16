import '../common/component_index.dart';

class NetRepository {
  ///用户端
  //获取验证码
  Future<BaseResp> getValidCode(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.VALIDCODE),
            data: reqData);
    return baseResp;
  }

  //短信验证码登录
  Future<BaseResp> userLogin(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.UserSignIn),
            data: reqData);
    if (baseResp.data != null)
      AppInstance.putObject("user", baseResp.data["userData"]);
    return baseResp;
  }

  //首次设置密码
  Future<BaseResp> setPwd(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.SetUserPwd),
            data: reqData);
    return baseResp;
  }

  //密码登录
  Future<BaseResp> userLoginByPwd(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.LoginByPassword),
            data: reqData);
    if (baseResp.data != null)
      AppInstance.putObject("user", baseResp.data["userData"]);
    return baseResp;
  }

  //找回密码
  Future<BaseResp> forgetPwd(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.ForgetPwd),
            data: reqData);
    return baseResp;
  }

  //修改手机号
  Future<BaseResp> changePhoneNum(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.ChangePhoneNum),
            data: reqData);
    return baseResp;
  }

  //用户认证
  Future<BaseResp> userAuth(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.UserCertificate),
            data: reqData);
    return baseResp;
  }

  //获取首页卡片列表
  Future<BaseResp> getCardInfo(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetCardInfo),
            data: reqData);
    return baseResp;
  }

  //更新账单
  Future<BaseResp> updateBill(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.UpdateBill),
            data: reqData);
    return baseResp;
  }

  //移除卡片
  Future<BaseResp> removeCard(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.RemoveCard),
            data: reqData);
    return baseResp;
  }

  //获取可添加卡片列表
  Future<BaseResp> getAddCardList(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetBankList),
            data: reqData);
    return baseResp;
  }

  //导入信用卡
  Future<BaseResp> importCardInfo(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.AddCreditCard),
            data: reqData);
    return baseResp;
  }

  //设置查询参数
  Future<BaseResp> setCardInput(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.SetCardInput),
            data: reqData);
    return baseResp;
  }

  //获取信用卡查询状态
  Future<BaseResp> getCardStatus(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetCardStatus),
            data: reqData);
    return baseResp;
  }

  //获取诊断卡片信息
  Future<BaseResp> getDiagnoseCardInfo(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post,
            RequestApi.getPath(path: RequestApi.GetDiagnoseCardList),
            data: reqData);
    return baseResp;
  }

  //卡片诊断
  Future<BaseResp> cardDiagnoseInfo(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.CardDiagnose),
            data: reqData);
    return baseResp;
  }

  //发起托管
  Future<BaseResp> startManager(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.StartManager),
            data: reqData);
    return baseResp;
  }

  //获取全部计划列表
  Future<BaseResp> getPlanLists(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetAllPlanLists),
            data: reqData);
    return baseResp;
  }

  //获取全部账单列表
  Future<BaseResp> getBillLists(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetAllBillLists),
            data: reqData);
    return baseResp;
  }

  //获取用户中心信息
  Future<BaseResp> getUserInfo(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetUserInfo),
            data: reqData);
    return baseResp;
  }

  //修改用户中心信息
  Future<BaseResp> editUserInfo(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.modifyUserInfo),
            data: reqData);
    return baseResp;
  }

  //修改用户密码
  Future<BaseResp> modifyPwd(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.ModifyPassword),
            data: reqData);
    return baseResp;
  }

  //获取我的管理师列表
  Future<BaseResp> getMyMasterLists(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.GetMyMasterLists),
            data: reqData);
    return baseResp;
  }

  //获取管理师下某个订单的卡片
  Future<BaseResp> getMasterOrderCards(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post,
            RequestApi.getPath(path: RequestApi.GetMasterOrderCards),
            data: reqData);
    return baseResp;
  }

  //角色升级
  Future<BaseResp> userUpgrade(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, RequestApi.getPath(path: RequestApi.UserUpgrade),
            data: reqData);
    return baseResp;
  }

  //余额明细
  Future<BaseResp> getUserBanalanceDetail(reqData) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post,
            RequestApi.getPath(path: RequestApi.GetUserBanalanceDetail),
            data: reqData);
    return baseResp;
  }
}

 