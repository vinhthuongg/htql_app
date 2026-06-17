import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htql_app/presentation/UI/docs/docs_screen.dart';
import 'package:htql_app/presentation/UI/event/event_sreen.dart';
import 'package:htql_app/presentation/UI/home/home_screen.dart';
import 'package:htql_app/presentation/UI/leave/leave_screen.dart';
import 'package:htql_app/presentation/provider/bottomnavigation_provider.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
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
    final selectedColor = AppColor.toyotaRed;
    final unselectedColor = AppColor.secondaryTextColor(context);
    final backgroundColor = AppColor.cardColor(context);

    Color getColor(int index) {
      return bottomProvider.seletedIndex == index
          ? selectedColor
          : unselectedColor;
    }

    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      currentIndex: bottomProvider.seletedIndex,
      onTap: bottomProvider.setSeletedIndex,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      type: BottomNavigationBarType.fixed,

      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/ic_home.svg",
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(getColor(0), BlendMode.srcIn),
          ),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/ic_leave.svg",
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(getColor(1), BlendMode.srcIn),
          ),
          label: 'Leave',
        ),

        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/ic_book.svg",
            width: 26,
            height: 26,
            colorFilter: ColorFilter.mode(getColor(2), BlendMode.srcIn),
          ),
          label: 'Docs',
        ),

        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/ic_event.svg",
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(getColor(3), BlendMode.srcIn),
          ),
          label: 'Events',
        ),
      ],
    );
  }
}
