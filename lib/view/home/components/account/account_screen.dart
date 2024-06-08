import 'package:eshop/view/home/components/account/auth/userInfo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../controller/controllers.dart';
import 'auth/sign_in_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Obx(()=> Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 36,
                backgroundImage: authController.user.value?.image != null
                    ? NetworkImage(authController.user.value!.image.toString()) // Chuyển đổi sang String
                    : null, // Ép kiểu thành ImageProvider
              ),



              const SizedBox(width: 10),
              Column(
                children:  [
                  Text(
                    authController.user.value?.name??"Đăng nhập tài khoảng",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),),
          const SizedBox(height: 50),
          Obx(
                () => buildAccountCard(
              title: authController.user.value == null ? "" : "Thông tin cá nhân",
              onClick: () {
                if (authController.user.value != null) {
                  // Nếu người dùng đã đăng nhập, chuyển hướng đến trang Profile và truyền token
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(token: authController.user.value!.token)),
                  );
                } else {
                  // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                }
              },
            ),
          ),

          buildAccountCard(title: "Thông báo", onClick: () {}),
          buildAccountCard(title: "Cài đặc", onClick: () {}),
          Obx(() => buildAccountCard(title: authController.user.value==null?"Đăng nhập":
          "Sign Out", onClick: () {
            if(authController.user.value!=null){
              authController.signOut();
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            }
          }))
        ],
      ),
    );
  }

  Widget buildAccountCard(
      {required String title, required Function() onClick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.1,
                  blurRadius: 7,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
