import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/content_view.dart';
import 'package:myportfolio/custom_tab.dart';

import 'custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;
  late double topPadding;
  late double bottomPadding;
  late TabController tabController;
  List<ContentView> contentViews = [
    ContentView(
      content: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.green,
        ),
      ),
      tab: CustomTab(title: 'Home'),
    ),
    ContentView(
      content: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
      ),
      tab: CustomTab(title: 'About'),
    ),
    ContentView(
      content: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      ),
      tab: CustomTab(title: 'Projects'),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    topPadding = screenHeight * 0.03;
    bottomPadding = screenHeight * 0.01;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 22, 22, 22),
        endDrawer: drawer(),
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          child: Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_veki9s25.json'),
          onPressed: () {},
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding),
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 715) {
              return desktopView();
            } else {
              return mobileView();
            }
          }),
        ));
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTabBar(
          controller: tabController,
          tabs: contentViews.map((e) => e.tab).toList(),
        ),
        Container(
          height: screenHeight * 0.85,
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              iconSize: screenWidth * 0.08,
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              icon: Icon(Icons.menu_rounded),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
              Container(
                height: screenHeight * 0.1,
              ),
            ] +
            contentViews
                .map((e) => Container(
                      child: ListTile(
                        title: Text(e.tab.title),
                        onTap: () {},
                      ),
                    ))
                .toList(),
      ),
    );
  }
}
