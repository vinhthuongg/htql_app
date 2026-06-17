import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/home/widgets/category_button.dart';
import 'package:htql_app/presentation/UI/home/widgets/category_card.dart';
import 'package:htql_app/presentation/UI/home/widgets/home_header.dart';
import 'package:htql_app/presentation/UI/home/widgets/information_card.dart';
import 'package:htql_app/presentation/UI/home/widgets/title_and_icon.dart';
import 'package:htql_app/presentation/router/app_router.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
      child: Column(
        children: [
          HomeHeader(),
          SizedBox(height: 18),
          InformationCard(),
          SizedBox(height: 24),
          TitleAndIcon(title: 'Hồ Sơ', icon: Icons.badge_outlined),
          SizedBox(height: 14),
          CategoryCard(
            buttons: [
              CategoryButton(
                title: 'Cá Nhân',
                icon: Icons.person_outline,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.personalScreen);
                },
              ),
              CategoryButton(
                title: 'Công Việc',
                icon: Icons.work_outline,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.workScreen);
                },
              ),
              CategoryButton(
                title: 'Hợp Đồng',
                icon: Icons.description_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.contractScreen);
                },
              ),
              CategoryButton(
                title: 'Chứng Chỉ',
                icon: Icons.badge_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.certificateScreen);
                },
              ),
            ],
          ),
          SizedBox(height: 22),
          TitleAndIcon(title: 'Nhân Sự', icon: Icons.account_tree_outlined),
          SizedBox(height: 14),
          CategoryCard(
            buttons: [
              CategoryButton(
                title: 'Luân Chuyển',
                icon: Icons.sync_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.transferScreen);
                },
              ),
              CategoryButton(
                title: 'Bổ Nhiệm',
                icon: Icons.add_circle_outline,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.appointmentScreen);
                },
              ),
              CategoryButton(
                title: 'Khen Thưởng',
                icon: Icons.star_outline,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.rewardScreen);
                },
              ),
            ],
          ),
          SizedBox(height: 22),
          TitleAndIcon(title: 'Tiện Ích', icon: Icons.apps_outlined),
          SizedBox(height: 14),
          CategoryCard(
            buttons: [
              CategoryButton(
                title: 'Chấm Công',
                icon: Icons.access_time_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.attendanceScreen);
                },
              ),
              CategoryButton(
                title: 'Bảng Lương',
                icon: Icons.account_balance_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.salaryScreen);
                },
              ),
            ],
          ),
          SizedBox(height: 22),
          TitleAndIcon(title: 'Khác', icon: Icons.more_horiz_outlined),
          SizedBox(height: 14),
          CategoryCard(
            buttons: [
              CategoryButton(
                title: 'Góp Ý',
                icon: Icons.feedback_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.feedbackScreen);
                },
              ),
              CategoryButton(
                title: 'Setting',
                icon: Icons.settings_outlined,
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.settingScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
