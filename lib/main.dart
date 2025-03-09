import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_shop/data/model/card_item.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/screens/dashbord_screen.dart';
import 'package:flutter_ecommerce_shop/screens/login_screen.dart';
import 'package:flutter_ecommerce_shop/util/auth_manager.dart';
import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('cardBox');
  await getItInit();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box = Hive.box<BasketItem>('cardBox');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: globalNavigatorKey,
        debugShowCheckedModeBanner: false,
        home: (AuthManager.readAuth().isEmpty)
            ? LoginScreen()
            : DashbordScreen());
  }
}
