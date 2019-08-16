import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class SetPwdMiddle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetPwdMiddleState();
}

class SetPwdMiddleState extends State<SetPwdMiddle> {
  bool openObs = true;
  bool openObs2 = true;
  var pwdInputCtrl = TextEditingController();
  var pwd2InputCtrl = TextEditingController();
  bool isInput = false;

  @override
  Widget build(BuildContext context) {
    SetPwdBloc setPwdBloc = BlocProvider.of<SetPwdBloc>(context);
    setPwdBloc.bloccontext = context;
    return Container(
      padding: EdgeInsets.only(left: 16, top: 30, right: 16),
      child: Column(
        children: <Widget>[
          Container(
            width: 343,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF999999),
                width: 1.0,
              ),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  child: Center(
                    child: Text(
                      "设置密码",
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: pwdInputCtrl,
                    style: TextStyles.text15MediumLabel,
                    decoration: new InputDecoration(
                      hintText: '请输入新密码',
                      hintStyle: TextStyles.text15MediumPLabel,
                      border: InputBorder.none,
                    ),
                    obscureText: openObs,
                    keyboardType: openObs ? null : TextInputType.url,
                     onChanged: ((_){
                      setState(() {
                        if(pwd2InputCtrl.text.length > 0){
                           isInput = true;
                        }else {
                          isInput = false;
                        }
                      });
                    }),
                  ),
                ),
                Container(
                  width: 52,
                  height: 50,
                  child: FlatButton(
                    child: openObs
                        ? Image.asset('assets/images/user/obscure_close.png')
                        : Image.asset('assets/images/user/obscure_show.png'),
                    onPressed: () {
                      setState(() {
                        openObs = !openObs;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 343,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF999999),
                width: 1.0,
              ),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  child: Center(
                    child: Text(
                      "确认密码",
                      style: TextStyles.text15MediumLabel,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: pwd2InputCtrl,
                    style: TextStyles.text15MediumLabel,
                    decoration: new InputDecoration(
                      hintText: '请重复输入新密码',
                      hintStyle: TextStyles.text15MediumPLabel,
                      border: InputBorder.none,
                    ),
                    obscureText: openObs2,
                    keyboardType: openObs2 ? null : TextInputType.url,
                    onChanged: ((_){
                     setState(() {
                        if(pwdInputCtrl.text.length > 0){
                           isInput = true;
                        }else {
                          isInput = false;
                        }
                      });
                    }),
                  ),
                ),
                Container(
                  width: 52,
                  height: 50,
                  child: FlatButton(
                    child: openObs2
                        ? Image.asset('assets/images/user/obscure_close.png')
                        : Image.asset('assets/images/user/obscure_show.png'),
                    onPressed: () {
                      setState(() {
                        openObs2 = !openObs2;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 99,
          ),
          Container(
            width: 245,
            height: 40,
            // padding: EdgeInsets.only(top: 99, left: 49, right: 49),
            child: RaisedButton(
              textColor: Color(0xFFFFFFFF),
              color: isInput ? Theme.of(context).accentColor : Colours.gray_cc,
              shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                "确认",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (pwdInputCtrl.text.length == 0) {
                  setPwdBloc.showToast("请输入登录密码");
                  return;
                }
                if (pwd2InputCtrl.text.length == 0) {
                  setPwdBloc.showToast("请再次输入登录密码");
                  return;
                }
                if (pwdInputCtrl.text != pwd2InputCtrl.text) {
                  setPwdBloc.showToast("两次输入密码不一致");
                  return;
                }
                setPwdBloc.setPwdAction(pwdInputCtrl.text);

                //显示注册成功弹窗
                // showDialog<void>(
                //   context: context,
                //   barrierDismissible: true, // user must tap button!
                //   builder: (BuildContext context) {
                //     return Center(
                //       child: Container(
                //         width: 170,
                //         height: 100,
                //         color: Colors.white,
                //         child: Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[
                //               Text(
                //                 "注册成功",
                //                 style: TextStyle(
                //                     fontSize: 20, color: Color(0xFF121212)),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(top: 5),
                //                 child: Image(
                //                     image: AssetImage(
                //                         'assets/images/user/login_success.png')),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
