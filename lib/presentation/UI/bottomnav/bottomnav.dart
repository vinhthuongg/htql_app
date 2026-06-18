import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htql_app/presentation/UI/docs/docs_screen.dart';
import 'package:htql_app/presentation/UI/event/event_sreen.dart';
import 'package:htql_app/presentation/UI/home/home_screen.dart';
import 'package:htql_app/presentation/UI/leave/leave_screen.dart';
import 'package:htql_app/presentation/provider/bottomnavigation_provider.dart';
import 'package:htql_app/presentation/router/app_router.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  static const List<Widget> pages = [
    HomeScreen(),
    LeaveScreen(),
    DocsScreen(),
    EventSreen(),
  ];

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  bool _isQuickMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomnavigationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: BottomNav.pages[provider.seletedIndex],
          floatingActionButton: _QuickActionMenu(
            isOpen: _isQuickMenuOpen,
            onToggle: () {
              setState(() {
                _isQuickMenuOpen = !_isQuickMenuOpen;
              });
            },
            onOvertimeTap: () {
              setState(() {
                _isQuickMenuOpen = false;
              });
              Navigator.pushNamed(context, AppRouter.overtimeScreen);
            },
            onLeaveTap: () {
              setState(() {
                _isQuickMenuOpen = false;
              });
              context.read<BottomnavigationProvider>().setSeletedIndex(1);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

class _QuickActionMenu extends StatelessWidget {
  const _QuickActionMenu({
    required this.isOpen,
    required this.onToggle,
    required this.onOvertimeTap,
    required this.onLeaveTap,
  });

  final bool isOpen;
  final VoidCallback onToggle;
  final VoidCallback onOvertimeTap;
  final VoidCallback onLeaveTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 174,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: isOpen
                ? Column(
                    key: const ValueKey<String>('quick-actions-open'),
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _QuickActionPill(
                        icon: Icons.more_time_outlined,
                        title: 'Tăng ca',
                        onTap: onOvertimeTap,
                      ),
                      SizedBox(height: 10),
                      _QuickActionPill(
                        icon: Icons.event_available_outlined,
                        title: 'Nghỉ phép',
                        onTap: onLeaveTap,
                      ),
                      SizedBox(height: 12),
                    ],
                  )
                : const SizedBox.shrink(
                    key: ValueKey<String>('quick-actions-closed'),
                  ),
          ),
          FloatingActionButton(
            backgroundColor: AppColor.toyotaRed,
            foregroundColor: AppColor.white,
            shape: const CircleBorder(),
            onPressed: onToggle,
            child: AnimatedRotation(
              turns: isOpen ? 0.125 : 0,
              duration: const Duration(milliseconds: 180),
              child: Icon(isOpen ? Icons.close_rounded : Icons.menu_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionPill extends StatelessWidget {
  const _QuickActionPill({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.toyotaRed,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColor.white, size: 20),
            SizedBox(width: 10),
            AppText(
              text: title,
              style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                color: AppColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
