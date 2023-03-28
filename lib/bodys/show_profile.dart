import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/models/user_model.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:flutter_test1/widgets/show_progress.dart';
import 'package:flutter_test1/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({Key? key}) : super(key: key);

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    findUserLogin();
  }

  Future<void> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idUserLogin = preferences.getString('id');
    var urlAPI =
        '${MyConstant.domain}/boneclinic/getUserWhereid.php?isAdd=true&members_id=$idUserLogin';
    await Dio().get(urlAPI).then((value) async {
      for (var item in json.decode(value.data)) {
        // print('item ==>> $item');
        setState(() {
          userModel = UserModel.fromMap(item);
          print('### id login ==> ${userModel!.members_id}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แสดงโปรไฟล์ของฉัน '),
        ),
        body: userModel == null ? showProgress() : ShowProFile());
  }

  LayoutBuilder ShowProFile() {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ShowTitle(
                  title: '  ชื่อ : ${userModel!.name} ${userModel!.surname}  ',
                  textStyle: MyConstant().h2style(),
                ),
              ),
              ShowTitle(
                title: ' ',
                textStyle: MyConstant().h2style(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShowTitle(
                        title: userModel == null
                            ? 'ที่อยู่ :'
                            : 'ที่อยู่ : ${userModel!.address}  ',
                        textStyle: MyConstant().h2style(),
                      ),
                    ),
                  ),
                ],
              ),
              ShowTitle(
                title: 'เบอร์โทรศัพท์ ${userModel!.phone}',
                textStyle: MyConstant().h2style(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
