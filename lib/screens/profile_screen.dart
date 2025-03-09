import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/screens/login_screen.dart';
import 'package:flutter_ecommerce_shop/util/auth_manager.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 35, bottom: 32, top: 15),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Image.asset('images/icon_apple_blue.png'),
                  const Expanded(
                    child: Text(
                      'حساب کاربری',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: CustomColors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'مبین احمدی',
            style: TextStyle(fontSize: 16, fontFamily: 'SB'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '09909804320',
            style: TextStyle(fontSize: 10, fontFamily: 'SM'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              AuthManager.logOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text('logout'),
          ),
          const Wrap(
            textDirection: TextDirection.rtl,
            spacing: 50,
            runSpacing: 20,
            children: [
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
              // CategoryItemChip(),
            ],
          ),
          const Spacer(),
          const Text(
            'اپل شاپ',
            style: TextStyle(
              fontFamily: 'sm',
              fontSize: 10,
              color: CustomColors.grey,
            ),
          ),
          const Text(
            'v-1.0.00',
            style: TextStyle(
              fontFamily: 'sm',
              fontSize: 10,
              color: CustomColors.grey,
            ),
          ),
          const Text(
            'Inistageram.com/Mojava-dev',
            style: TextStyle(
              fontFamily: 'sm',
              fontSize: 10,
              color: CustomColors.grey,
            ),
          ),
        ],
      )),
    );
  }
}
