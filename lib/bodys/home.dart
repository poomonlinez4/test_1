import 'package:flutter/material.dart';
import 'package:flutter_test1/bodys/show_list.dart';
import 'package:flutter_test1/bodys/show_profile.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:flutter_test1/widgets/show_title.dart';

class ShowHomepageAdmin extends StatefulWidget {
  const ShowHomepageAdmin({Key? key}) : super(key: key);

  @override
  State<ShowHomepageAdmin> createState() => _ShowHomepageAdminState();
}

class _ShowHomepageAdminState extends State<ShowHomepageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowTitle(
              title: "Home Page",
              textStyle: MyConstant().h1style(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: ElevatedButton(
                            style: MyConstant().myButtonStyleBack(),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowProfile();
                              }));
                            },
                            child: Text('Profile'),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 200,
                          margin: EdgeInsets.only(top: 0.1),
                          child: ElevatedButton(
                            style: MyConstant().myButtonStyleBack(),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowListEmployeeRegister();
                              }));
                            },
                            child: Text('List'),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
