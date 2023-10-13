import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/user_info_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/utils/log_util.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with BasePage<LoginRegisterPage> {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  _onButtonClick() async {
    WanLog.i("请求-----");
    WanLog.i("请求-----userName : ${nameTextController.text}");
    WanLog.i("请求-----password : ${passwordTextController.text}");
    AppResponse<UserInfoEntity> res = await HttpGo.instance.post(Api.login,
        data: {
          "username": nameTextController.text,
          "password": passwordTextController.text
        });
    WanLog.i("请求-----result : ${res.data?.nickname}");
    showTextToast(res.data?.toString() ??"没结果");
  }

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
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: const BoxDecoration(color: Colors.lightGreen),
                child: SizedBox.fromSize(
                  size: const Size(double.infinity, 60),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                controller: nameTextController,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
                        EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    hintText: "密码",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: TextButton(onPressed: _onButtonClick, child: Text("登录")),
            )
          ],
        ),
      ),
    );
  }
}
