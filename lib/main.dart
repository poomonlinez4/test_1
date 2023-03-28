import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test1/states/admin_service.dart';
import 'package:flutter_test1/states/authen.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/adminService': (BuildContext context) => AdminService(),
};

String? initlalRoute;

Future<Null> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  //******* แบ่งตาม type
  //SharedPreferences บันทึก something ลงในเครื่องง
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case '1':
        initlalRoute = MyConstant.routeAdminService;
        runApp(MyApp());
        break;
      case '3':
        initlalRoute = MyConstant.routeCoustomerService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xffba6b6c, MyConstant.mapMaterialColor);

    HttpOverrides.global = MyHttpOverrides();
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
      theme: ThemeData(
        primarySwatch: materialColor,
        // textTheme:
        //     GoogleFonts.ibmPlexSansThaiTextTheme(Theme.of(context).textTheme)
        //         .copyWith(bodyText1: TextStyle(fontSize: 16)),
      ),
    );
  }
}

class MyhttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
