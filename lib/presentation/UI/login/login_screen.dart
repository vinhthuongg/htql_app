import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/login/widgets/widget_textformfield.dart';
import 'package:htql_app/presentation/router/app_router.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: _buildBody()));
  }

  Widget _buildBody() {
    bool isChecked = false;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset(
              'assets/images/img_toyota.png',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 20),
            AppText(text: 'Welcome Back', style: AppTextstyle.tsSemiBoldRed32),
            SizedBox(height: 5),
            AppText(
              text: 'Please login to your account',
              style: AppTextstyle.tsRegularBlack16,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text: 'Tài Khoản',
                style: AppTextstyle.tsRegularBlack16,
              ),
            ),
            SizedBox(height: 10),
            WidgetTextformfield(hintText: 'Nhập tài khoản'),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text: 'Mật Khẩu',
                style: AppTextstyle.tsRegularBlack16,
              ),
            ),
            SizedBox(height: 10),
            WidgetTextformfield(hintText: 'Nhập mật khẩu'),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text('Ghi nhớ đăng nhập'),
                ],
              ),
            ),
            SizedBox(height: 40),

            AppButton(
              text: 'Login',
              onTap: () {
                Navigator.pushNamed(context, AppRouter.bottomNav);
              },
            ),
          ],
        ),
      ),
    );
  }
}
