import 'package:flutter/material.dart';
import 'package:wechat/pages/chat_view_page.dart';
import 'package:wechat/pages/contacts_view_page.dart';
import 'package:wechat/pages/me_profile_view_page.dart';
import 'package:wechat/pages/setting_view_page.dart';
import 'package:wechat/resources/colors.dart';
import 'newsfeed_for_moments_view_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeChatHomeNavigationViewPage extends StatefulWidget {
  const WeChatHomeNavigationViewPage({Key? key}) : super(key: key);

  @override
  State<WeChatHomeNavigationViewPage> createState() => _WeChatHomeNavigationViewPageState();
}

class _WeChatHomeNavigationViewPageState extends State<WeChatHomeNavigationViewPage> {

  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late Widget _page4;
  late Widget _page5;

  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _page1 = NewsfeedForMomentsViewPage();
    _page2 = ChatViewPage();
    _page3 = ContactsViewPage();
    _page4 = MeProfileViewPage();
    _page5 = SettingViewPage();
    _pages = [_page1, _page2, _page3, _page4, _page5];
    _currentIndex = 0;
    _currentPage = _page1;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _currentPage,
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changeTab(index);
          print(index);
        },
        currentIndex: _currentIndex,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/moment_icon.png"),
            ),
            label: 'Moment',
          ),

          // BottomNavigationBarItem(
          //     icon: SvgPicture.asset("assets/images/moment_icon.svg"),
          //     label: "Moment"
          // ),
          // BottomNavigationBarItem(
          //   icon:
          //   // ImageIcon(
          //     SvgPicture.asset("assets/images/nav_cinema.png"),
          //   // ),
          //   label: 'Chat',
          // ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/chat_icon.svg",
                  color: _currentIndex == 1 ? PRIMARY_COLOR : PRIMARY_HINT_COLOR
              ),
              label: "Chat"
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/contact_icon.svg",
                  color: _currentIndex == 2 ? PRIMARY_COLOR : PRIMARY_HINT_COLOR
              ),
              label: "Contacts"
          ),
          BottomNavigationBarItem(
            // icon: ImageIcon(Icons.pe),
            icon:
              SvgPicture.asset("assets/images/me_icon.svg",
                  color: _currentIndex == 3 ? PRIMARY_COLOR : PRIMARY_HINT_COLOR
              ),

            label: 'Me',
          ) ,
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/menu_icon.svg",
                color: _currentIndex == 4 ? PRIMARY_COLOR : PRIMARY_HINT_COLOR
            ),
            label: 'Setting',
          )
        ],
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: PRIMARY_HINT_COLOR,
      ),
    );
  }
}
