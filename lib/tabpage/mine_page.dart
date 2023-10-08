
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/base/base_page.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _MinePageState();
}


class _MinePageState extends State<MinePage> with BasePage<MinePage>, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Center(
      child: Text("mine"),
    );
  }

  @override
  bool get wantKeepAlive => true;

}