import 'package:chapter_5/screens/home_screen.dart';
import 'package:chapter_5/screens/profile_screen.dart';
import 'package:chapter_5/screens/tabs_screen.dart';
import 'package:chapter_5/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _bottomNavigationIndex = 0;
  int _tabIndex = 0;

  List<Widget> screens = <Widget>[
    const HomeScreen(),
    TabsScreen(tabIndex: 0),
    const ProfileScreen(),
  ];

  _provideTabScreen() {
    screens[1] = TabsScreen(tabIndex: _tabIndex);
  }

  final List<String> labels = ["Home", "Tabs", "Profile"];
  final List<IconData> icons = [
    Icons.home,
    Icons.table_view_outlined,
    Icons.person,
  ];

  _updateBottomNavIndex(int index) =>
      setState(() => _bottomNavigationIndex = index);

  List<Widget> tabs = const <Tab>[Tab(text: "Android"), Tab(text: "iOS")];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: _tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: const Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _bottomNavigationIndex = 1;
              _tabIndex = 1;
              _provideTabScreen();
              _tabController.animateTo(1);
            });
          },
          // shape: const CircleBorder(),
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.black,
          child: const Icon(
            CupertinoIcons.arrow_up_arrow_down,
            size: 35.0,
          ),
        ),
        appBar: AppBar(
            foregroundColor: Colors.redAccent,
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 30.0,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
            title: Text(
              labels[_bottomNavigationIndex],
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                fontFamily: 'Times new roman',
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black.withOpacity(0.6),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white.withOpacity(0.7),
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black.withOpacity(0.7),
            ),
            bottom: (_bottomNavigationIndex == 1)
                ? TabBar(
                    indicatorColor: Colors.redAccent,
                    dividerColor: Colors.orange,
                    labelColor: Colors.red,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times new roman',
                    ),
                    unselectedLabelColor: Colors.orange,
                    unselectedLabelStyle: const TextStyle(fontSize: 16.0),
                    tabs: tabs,
                    controller: _tabController,
                    onTap: (index) => setState(() {
                      _tabIndex = index;
                      _provideTabScreen();
                    }),
                  )
                : const PreferredSize(
                    preferredSize: Size.fromHeight(0.0), child: SizedBox())),
        body: screens[_bottomNavigationIndex],
        bottomNavigationBar: Container(
          width: Constants.deviceWidth,
          height: Constants.scaffoldHeight * 0.100,
          margin: Constants.marginAll,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                spreadRadius: 1.0,
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: labels.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => _updateBottomNavIndex(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: Constants.marginSym,
                  decoration: BoxDecoration(
                    color: (index == _bottomNavigationIndex)
                        ? Colors.white.withOpacity(0.1)
                        : null,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: (index == _bottomNavigationIndex) ? 35.0 : 30.0,
                        color: (index == _bottomNavigationIndex)
                            ? Colors.redAccent
                            : Colors.orange,
                      ),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize:
                              (index == _bottomNavigationIndex) ? 16.0 : 14.0,
                          fontWeight: (index == _bottomNavigationIndex)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: (index == _bottomNavigationIndex)
                              ? Colors.redAccent
                              : Colors.orange,
                          fontFamily: 'Times new roman',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
