import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/pages/login_register_page.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with BasePage<MinePage>, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset("assets/images/icon_collect.png",
                        width: 48, height: 48),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => LoginRegisterPage());
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          // 如果不设置decoration，container的大小貌似只有text大小。
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                          child: const Text("用户名"),
                        )),
                    const Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("积分： 1091"),
                    ))
                  ],
                )),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
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
