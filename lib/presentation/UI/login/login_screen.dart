import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/login/widgets/widget_textformfield.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/router/app_router.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberLogin = false;

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    _rememberLogin = authProvider.rememberLogin;
    if (_rememberLogin) {
      _usernameController.text = authProvider.rememberedUsername;
      _passwordController.text = authProvider.rememberedPassword;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: _buildBody()));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Image.asset(
                    'assets/images/img_toyota.png',
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 20),
                  AppText(
                    text: 'Welcome Back',
                    style: AppTextstyle.tsSemiBoldRed32,
                  ),
                  SizedBox(height: 5),
                  AppText(
                    text: 'Please login to your account',
                    style: AppTextstyle.tsRegularBlack16.copyWith(
                      color: AppColor.primaryTextColor(context),
                    ),
                  ),
                  SizedBox(height: 20),
                  _Label(text: 'Tài Khoản'),
                  SizedBox(height: 10),
                  WidgetTextformfield(
                    hintText: 'Nhập tài khoản',
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 20),
                  _Label(text: 'Mật Khẩu'),
                  SizedBox(height: 10),
                  WidgetTextformfield(
                    hintText: 'Nhập mật khẩu',
                    controller: _passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    validator: _requiredValidator,
                  ),
                  SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: _rememberLogin,
                          activeColor: AppColor.toyotaRed,
                          onChanged: (value) {
                            setState(() {
                              _rememberLogin = value ?? false;
                            });
                          },
                        ),
                        AppText(
                          text: 'Ghi nhớ đăng nhập',
                          style: AppTextstyle.tsMediumGrey14.copyWith(
                            color: AppColor.secondaryTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (authProvider.errorMessage != null) ...[
                    SizedBox(height: 12),
                    AppText(
                      text: authProvider.errorMessage!,
                      style: AppTextstyle.tsMediumRed12,
                    ),
                  ],
                  SizedBox(height: 32),
                  authProvider.isLoading
                      ? CircularProgressIndicator(color: AppColor.toyotaRed)
                      : AppButton(
                          text: 'Login',
                          onTap: () => _onLogin(authProvider),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Không được để trống';
    }

    return null;
  }

  Future<void> _onLogin(AuthProvider authProvider) async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await authProvider.login(
      username: _usernameController.text,
      password: _passwordController.text,
      rememberLogin: _rememberLogin,
    );

    if (!mounted || !success) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.bottomNav,
      (route) => false,
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppText(
        text: text,
        style: AppTextstyle.tsRegularBlack16.copyWith(
          color: AppColor.primaryTextColor(context),
        ),
      ),
    );
  }
}
