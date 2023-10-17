import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wan_android_flutter/constants/constants.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/search_page.dart';
import 'package:wan_android_flutter/pages/tabpage/home_page.dart';
import 'package:wan_android_flutter/pages/tabpage/mine_page.dart';
import 'package:wan_android_flutter/pages/tabpage/plaza_page.dart';
import 'package:wan_android_flutter/pages/tabpage/project_page.dart';
import 'package:wan_android_flutter/user.dart';
import 'package:wan_android_flutter/utils/error_handle.dart';
import 'package:wan_android_flutter/utils/log_util.dart';

Future<void> main() async {
  handleError(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化mmkv
    final rootDir = await MMKV.initialize();
    WanLog.i("mmkv rootDir: ${rootDir}");

    // 加载本地用户信息
    User().loadFromLocal();

    // 初始化dio
    configDio(baseUrl: Constant.baseUrl);

    setPathUrlStrategy();
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
      home: const MainPage(title: 'WanAndroidFlutter'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedItemIndex = 0;

  String _currentTitle = "首页";

  final PageController _pageController = PageController(initialPage: 0);

  final List<String> _titles = ["首页", "项目", "广场", "我的"];
  final List<Widget> _navIcons = [
    const Icon(Icons.home),
    const Icon(Icons.ac_unit),
    const Icon(Icons.animation),
    const Icon(Icons.verified_user_rounded)
  ];

  final List<Widget> _pages = [
    const HomePage(),
    const ProjectPage(),
    const PlazaPage(),
    const MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(_currentTitle, style: const TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            tooltip: '搜索',
            onPressed: () {
              Get.to(const SearchPage());
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        iconSize: 24,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: _generateBottomNavList(),
        currentIndex: _selectedItemIndex,
        onTap: _onNavItemTapped,
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _pages[index];
        },
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
    );
  }

  List<BottomNavigationBarItem> _generateBottomNavList() {
    return List.generate(_titles.length, (index) {
      return BottomNavigationBarItem(
          icon: _navIcons[index], label: _titles[index]);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedItemIndex = index;
      _currentTitle = _titles[index];
    });
  }

  void _onNavItemTapped(int index) {
    // _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    _pageController.jumpToPage(index);
  }
}
