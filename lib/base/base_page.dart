import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin BasePage<T extends StatefulWidget> on State<T> {
  /// 是否正在显示loading弹窗
  bool showingLoading = false;

  showLoadingDialog() async {
    if (showingLoading) {
      return;
    }
    showingLoading = true;
    await showDialog<int>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text("请稍候..."),
                )
              ],
            ),
          );
        });
    showingLoading = false;
  }

  dismissLoading() {
    if (showingLoading) {
      Navigator.of(context).pop();
    }
  }
}

class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, required this.onTapRetry});

  final void Function() onTapRetry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTapRetry,
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Icon(Icons.refresh)),
              Text("加载失败，点击重试")
            ],
          ),
        ));
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 16), child: Icon(Icons.book)),
          Text("无数据")
        ],
      ),
    );
  }
}
