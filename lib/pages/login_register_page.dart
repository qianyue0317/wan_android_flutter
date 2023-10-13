import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/user_info_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with BasePage<LoginRegisterPage> {
  final TextEditingController nameTextController = TextEditingController();

  final TextEditingController passwordTextController = TextEditingController();

  final Key loginBtnKey = GlobalKey();

  final Key modeBtnKey = GlobalKey();

  final TextEditingController repasswordTextController =
      TextEditingController();

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "登录/注册",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                controller: nameTextController,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    hintText: "用户名",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                obscureText: true,
                controller: passwordTextController,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    hintText: "密码",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
              ),
            ),
            if (!isLogin)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextField(
                  obscureText: true,
                  controller: repasswordTextController,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      hintText: "确认密码",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ),
              ),
            Container(
              key: loginBtnKey,
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: _onLoginOrRegister,
                  child: Text(isLogin ? "登录" : "注册")),
            ),
            Container(
              key: modeBtnKey,
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: _onChangeMode,
                  child: Text(isLogin ? "没有账号？去注册" : "已有账号？去登录")),
            ),
          ],
        ),
      ),
    );
  }

  void _onChangeMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  _onLoginOrRegister() async {
    AppResponse<UserInfoEntity> res = await HttpGo.instance.post(Api.login,
        data: {
          "username": nameTextController.text,
          "password": passwordTextController.text
        });
    if (res.isSuccessful) {}
    showTextToast(res.data?.toString() ?? "没结果");
  }
}
