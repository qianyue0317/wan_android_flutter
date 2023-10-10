import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with BasePage<LoginRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录/注册", style: TextStyle(color: Colors.white),),
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
                decoration: const BoxDecoration(
                  color: Colors.lightGreen
                ),
                child: SizedBox.fromSize(
                  size: Size(double.infinity, 60),
                ),
              ),
            ),
            TextField(

            )
          ],
        ),
      ),
    );
  }
}
