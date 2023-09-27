
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/base/base_page.dart';

class PlazaPage extends StatefulWidget {
  const PlazaPage({super.key});

  @override
  State<StatefulWidget> createState() => _PlazaState();

}

class _PlazaState extends State<PlazaPage> with BasePage<PlazaPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("plaza"),
    );
  }

}