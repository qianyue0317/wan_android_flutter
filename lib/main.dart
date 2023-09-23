import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';
import 'package:wan_android_flutter/constants/constants.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/utils/error_handle.dart';
import 'package:wan_android_flutter/utils/log_util.dart';

Future<void> main() async {
  handleError(() async {

    WidgetsFlutterBinding.ensureInitialized();

    // 初始化mmkv
    final rootDir = await MMKV.initialize();
    WanLog.i("mmkv rootDir: ${rootDir}");

    // 初始化dio
    configDio(baseUrl: Constant.baseUrl);

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "第一"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "第二"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "第三")
        ],
        currentIndex: _selectedItemIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
}
