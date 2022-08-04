//CodeWithFlexz on Instagram

//AmirBayat0 on Github
//Programming with Flexz on Youtube

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter_shimmer/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: MyThemes.darkTheme,
      theme: MyThemes.lightTheme,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  bool isShimmerActive = false;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          "Users List ",
          style: TextStyle(color: Colors.black),
        ),
        leading: const Icon(Icons.menu),
        backgroundColor: Colors.white,
        actions: const [
          Icon(
            CupertinoIcons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),

      /// FloatingActionButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            isShimmerActive = !isShimmerActive;
          });
        },
        child: const Icon(
          CupertinoIcons.arrow_2_circlepath,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,

      /// Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: const <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.compare_arrows, size: 30, color: Colors.white),
          Icon(Icons.call_split, size: 30, color: Colors.white),
          Icon(Icons.perm_identity, size: 30, color: Colors.white),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),

      /// Body
      body: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top mini Text
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            /// main List View
            Expanded(
              child: ListView.separated(
                itemCount: 15,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  final delay = (i * 300);
                  return ListTile(
                    leading: isShimmerActive
                        ? FadeShimmer.round(
                            size: 60,
                            fadeTheme:
                                isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            millisecondsDelay: delay,
                          )
                        : const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 179, 130, 188),
                            radius: 25,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                    title: isShimmerActive
                        ? FadeShimmer(
                            width: 20.0,
                            height: 10,
                            fadeTheme:
                                isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            millisecondsDelay: delay,
                          )
                        : const Text("Name"),
                    subtitle: isShimmerActive
                        ? FadeShimmer(
                            width: 20,
                            height: 10,
                            fadeTheme:
                                isDarkMode ? FadeTheme.dark : FadeTheme.light,
                            millisecondsDelay: delay,
                          )
                        : const Text("Surname"),
                    trailing: isShimmerActive
                        ? null
                        : const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                          ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
