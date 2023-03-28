import 'package:flutter/material.dart';
import 'package:flutter_test1/bodys/home.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:flutter_test1/widgets/show_signout.dart';
import 'package:flutter_test1/widgets/show_title.dart';

class AdminService extends StatefulWidget {
  const AdminService({Key? key}) : super(key: key);
  @override
  State<AdminService> createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  List<Widget> widgets = [
    ShowHomepageAdmin(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('(Admin)'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowHomepage(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowHomepage() {
    return ListTile(
      onTap: (() {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      }),
      leading: Icon(Icons.filter_1),
      title: ShowTitle(title: 'Home page', textStyle: MyConstant().h2style()),
      subtitle: ShowTitle(title: 'หน้าหลัก', textStyle: MyConstant().h3style()),
    );
  }
}
