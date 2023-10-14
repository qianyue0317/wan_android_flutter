import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/pages/login_register_page.dart';
import 'package:wan_android_flutter/user.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with BasePage<MinePage>, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    User().on(_onLoginChange);
  }

  @override
  void dispose() {
    super.dispose();
    User().off(_onLoginChange);
  }

  void _onLoginChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor
        ),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          AssetImage("assets/images/ic_default_avatar.png"),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (!User().isLoggedIn()) {
                            Get.to(() => const LoginRegisterPage());
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          // 如果不设置decoration，container的大小貌似只有text大小。
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                          child: Text(
                              User().isLoggedIn() ? User().userName : "登录/注册"),
                        )),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(User().isLoggedIn()
                              ? "积分：${User().userCoinCount.toString()}"
                              : "积分：--")),
                    )
                  ],
                )),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                  )
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
