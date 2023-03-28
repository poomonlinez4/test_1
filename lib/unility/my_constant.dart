import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'แบบทดสอบ';
  static String domain = 'http://202.28.34.205:8080/62011211039';
  static String host = 'https://cca7-49-48-117-154.ap.ngrok.io';

 
  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeCoustomerService = '/customerService';
  static String routeAdminService = '/adminService';
  static String routeEditProfileCustomer = '/editProfileCustomer';
  static String routeShowProfile = '/showProfile';
  
  // Image
  static String image1 = 'images/image (1).png';
  static String image2 = 'images/image (2).png';
  static String image3 = 'images/image (3).png';
  static String image4 = 'images/image (4).png';
  static String image5 = 'images/image (5).png';
  static String image6 = 'images/image (6).png';
  static String image7 = 'images/image (7).png';
  static String image8 = 'images/image (8).png';
  static String image9 = 'images/image 9.png';
  static String avatar = 'images/avatar.png';
  static String HotDeal02 = 'images/HotDeal02.jpg';
  static String tb_doctor = 'images/tb_doctor.jpg';

  //Color
  static Color primary = Color(0xffef9a9a);
  static Color dark = Color(0xffba6b6c);
  static Color light = Color(0xffffcccb);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(186, 107, 108, 0.1),
    100: Color.fromRGBO(186, 107, 108, 0.2),
    200: Color.fromRGBO(186, 107, 108, 0.3),
    300: Color.fromRGBO(186, 107, 108, 0.4),
    400: Color.fromRGBO(186, 107, 108, 0.5),
    500: Color.fromRGBO(186, 107, 108, 0.6),
    600: Color.fromRGBO(186, 107, 108, 0.7),
    700: Color.fromRGBO(186, 107, 108, 0.8),
    800: Color.fromRGBO(186, 107, 108, 0.9),
    900: Color.fromRGBO(186, 107, 108, 1.0),
  };

  //Background
  BoxDecoration planBackground() => BoxDecoration(color: Colors.black12);
  BoxDecoration planBackgroundLight() => BoxDecoration(color: MyConstant.light);

  BoxDecoration planBackgroundPrimary() =>
      BoxDecoration(color: MyConstant.primary);
  BoxDecoration planBackgroundDark() => BoxDecoration(color: MyConstant.dark);

  BoxDecoration gradintLinearBackground() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, MyConstant.light, MyConstant.primary],
        ),
      );

  BoxDecoration gradientRadioBackground() => BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.5),
          radius: 1.5,
          colors: [Colors.white, MyConstant.primary],
        ),
      );

  // Style
  TextStyle h1style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h1Whitestyle() => TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle h1Redstyle() => TextStyle(
        fontSize: 24,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2Whitestyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2RedStyle() => TextStyle(
        fontSize: 18,
        color: Colors.red.shade700,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2GreenStyle() => TextStyle(
        fontSize: 18,
        color: Colors.green.shade800,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2BlueStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue.shade800,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3Whitestyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3RedStyle() => TextStyle(
        fontSize: 14,
        color: Colors.red.shade700,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3BlueStyle() => TextStyle(
        fontSize: 14,
        color: Colors.blue.shade800,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3GreenStyle() => TextStyle(
        fontSize: 14,
        color: Colors.green.shade800,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3BlackStyle() => TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  TextStyle h4BlackStyle() => TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );

  ButtonStyle myButtonStyle2() => ElevatedButton.styleFrom(
        primary: MyConstant.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );

  ButtonStyle myButtonStyleBack() => ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );

  ButtonStyle myButtonStyleYellow() => ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 231, 207, 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );

  ButtonStyle myButtonStyleA() => ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 60, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );
}
