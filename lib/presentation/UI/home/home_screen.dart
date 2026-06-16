import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(children: [SizedBox(height: 100), _buildInfomation()]),
      ),
    );
  }

  Widget _buildInfomation() {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/img_avatar.jpg"),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Nguyễn Văn A',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/ic_rule.png',
                width: 20,
                height: 20,
                color: Colors.white, // Thay đổi màu sắc của icon thành trắng
              ),
              SizedBox(width: 5),
              AppText(
                text: 'Nhân Viên IT',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/ic_cty.png',
                width: 20,
                height: 20,
                color: Colors.white, // Thay đổi màu sắc của icon thành trắng
              ),
              SizedBox(width: 5),
              AppText(
                text: 'HCNS',
                style: AppTextstyle.tsRegularBlack16.copyWith(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          Row(

          )
        ],
      ),
    );
  }

}
