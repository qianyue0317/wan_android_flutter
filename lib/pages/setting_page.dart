import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/request_util.dart';

import '../user.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with BasePage<SettingPage> {
  _showLogoutDialog() async {
    if (!User().isLoggedIn()) {
      showTextToast("当前未登录");
      return;
    }
    bool result = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("提示"),
                content: const Text("确定要退出吗？"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back<bool>(result: false);
                      },
                      child: const Text("取消")),
                  TextButton(
                      onPressed: () {
                        Get.back<bool>(result: true);
                      },
                      child: const Text("确定"))
                ],
              );
            }) ??
        false;
    if (result) {
      showLoadingDialog();
      AppResponse<dynamic> res = await HttpGo.instance.get(Api.logout);
      dismissLoading();
      if (res.isSuccessful) {
        User().logout();
        showTextToast("已退出登录！");
      } else {
        showTextToast("退出登录失败-${res.errorMsg}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "系统设置",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: GestureDetector(
                    onTap: _showLogoutDialog,
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: Card(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: const Text("退出登录"))))))
          ],
        ));
  }
}
