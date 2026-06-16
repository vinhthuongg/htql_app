import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htql_app/presentation/UI/docs/docs_screen.dart';
import 'package:htql_app/presentation/UI/event/event_sreen.dart';
import 'package:htql_app/presentation/UI/home/home_screen.dart';
import 'package:htql_app/presentation/UI/leave/leave_screen.dart';
import 'package:htql_app/presentation/provider/bottomnavigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});
  static const List<Widget> pages = [
    HomeScreen(),
    LeaveScreen(),
    DocsScreen(),
    EventSreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomnavigationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: pages[provider.seletedIndex],
          bottomNavigationBar: _bottomNavigationBar(provider, context),
        );
      },
    );
  }


  BottomNavigationBar _bottomNavigationBar(
  BottomnavigationProvider bottomProvider,
  BuildContext context,
) {
  
  return BottomNavigationBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    currentIndex: bottomProvider.seletedIndex,
    onTap: bottomProvider.setSeletedIndex,
    selectedItemColor: Color(0XFF000000),
    unselectedItemColor: Color(0XFF000000),
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/ic_home.svg",width: 25, height: 25,
          colorFilter: ColorFilter.mode(
            bottomProvider.seletedIndex == 0
                ? Color(0XFF000000)
                : Color.fromARGB(255, 241, 2, 2),
            BlendMode.srcIn,
          ),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/ic_leave.svg",width: 24, height: 24,
          colorFilter: ColorFilter.mode(
            bottomProvider.seletedIndex == 1
                ? Color(0XFF000000)
                : Color.fromARGB(255, 241, 2, 2),
            BlendMode.srcIn,
          ),
        ),
        label: 'Leave',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/ic_book.svg",width: 26, height: 26,
          colorFilter: ColorFilter.mode(
            bottomProvider.seletedIndex == 2
                ? Color(0XFF000000)
                : Color.fromARGB(255, 241, 2, 2),
            BlendMode.srcIn,
          ),
        ),
        label: 'Docs',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/ic_event.svg",
          colorFilter: ColorFilter.mode(
            bottomProvider.seletedIndex == 3
                ? Color(0XFF000000)
                : Color.fromARGB(255, 241, 2, 2),
            BlendMode.srcIn,
          ),
        ),
        label: 'Events',
      ),
    ],
  );
}}