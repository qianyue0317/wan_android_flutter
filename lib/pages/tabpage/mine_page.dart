import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/pages/login_register_page.dart';
import 'package:wan_android_flutter/pages/setting_page.dart';
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
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          alignment: Alignment.centerLeft,
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
                color: Colors.white.withOpacity(0.95),
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
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.to(() => const SettingPage());
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "系统设置",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                        )))
                              ],
                            ),
                          ))
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
