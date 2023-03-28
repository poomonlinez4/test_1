import 'dart:convert';
import 'dart:math';
import 'package:flutter_test1/models/user_model.dart';
import 'package:flutter_test1/models/user_showlist_model.dart';
import 'package:flutter_test1/states/create_account.dart';
import 'package:flutter_test1/states/edit_customer.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:flutter_test1/unility/my_dialod.dart';
import 'package:flutter_test1/widgets/show_image.dart';
import 'package:flutter_test1/widgets/show_no_data.dart';
import 'package:flutter_test1/widgets/show_progress.dart';
import 'package:flutter_test1/widgets/show_title.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowListEmployeeRegister extends StatefulWidget {
  const ShowListEmployeeRegister({super.key});

  @override
  State<ShowListEmployeeRegister> createState() =>
      _ShowListEmployeeRegisterState();
}

class _ShowListEmployeeRegisterState extends State<ShowListEmployeeRegister> {
  bool load = true;
  bool? haveDoctor;
  UserModel? userModel;
  List<UserShowListModel> userShowListModel = [];
  List<List<String>> listImages = [];

  @override
  void initState() {
    // TODO: implement initState
    readAPI();
    super.initState();
  }

  Future<void> readAPI() async {
    String urlAPI = '${MyConstant.domain}/boneclinic/getUserAll.php?isAdd=true';
    await Dio().get(urlAPI).then((value) {
      print('### value = $value');

      if (value.toString() == 'null') {
        setState(() {
          haveDoctor = false;
          load = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          UserShowListModel model = UserShowListModel.fromMap(item);

          setState(() {
            haveDoctor = true;
            load = false;

            userShowListModel.add(model);
          });
        }
      }
    });
  }

  Future<void> confirmDelete(UserShowListModel userShowListModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image8),
          title: ShowTitle(
              title: 'ต้องการลบ ?', textStyle: MyConstant().h2style()),
          subtitle: ShowTitle(
              title: 'ข้อมูลลูกค้า ${userShowListModel.name}',
              textStyle: MyConstant().h3style()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              String url =
                  '${MyConstant.domain}/boneclinic/test_deleteWhereId.php?isAdd=true&members_id=${userShowListModel.members_id}';
              print(url);
              await Dio().get(url).then((value) {
                Navigator.pop(context);
                MyDialog().normalDialog(
                    context, 'ลบข้อมูลออก', 'ข้อมูลได้ถูกลบ เรียบร้อย !!!');
              });
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: load
          ? showProgress()
          : userShowListModel.isEmpty
              ? Container(
                  // decoration: MyConstant().gradintLinearBackground(),
                  child: ShowNoData(
                    title: 'ไม่พบ รายชื่อผู้ลงทะเบียน',
                    pathImage: MyConstant.image4,
                  ),
                )
              : buildContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateAccount();
          }));
        },
        child: Text('Add'),
      ),
    );
  }

  Container buildContent() {
    return Container(
      //   decoration: MyConstant().gradintLinearBackground(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowTitle(
                  title: 'รายชื่อลูกค้า', textStyle: MyConstant().h1style()),
            ),
            // buildDivider(),
            People_registered(),
            //  buildDivider(),
            SizedBox(height: 10),
            buildHead(),
            buildShowListEmp(),
            buildDivider(),

            // buttonController()
          ],
        ),
      ),
    );
  }

  Row People_registered() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShowTitle(
                  title: 'ลงทะเบียน :',
                  textStyle: MyConstant().h2BlueStyle(),
                ),
                ShowTitle(
                  //   title: total == null ? '' : total.toString(),
                  title: '${userShowListModel.length} คน',
                  textStyle: MyConstant().h2BlueStyle(),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   width: 200, height: 45,
        //   //color: Colors.black,
        //   child: Padding(
        //     padding: const EdgeInsets.only(right: 15.0),
        //     child: Container(
        //       child: Align(
        //         alignment: Alignment.centerRight,
        //         child: ElevatedButton(
        //           // style: ElevatedButton.styleFrom(primary: Colors.red),
        //           style: MyConstant().myButtonStyle(),
        //           onPressed: () {
        //             setState(() {
        //               readAPI();
        //               buildContent();
        //             });
        //           },
        //           child: Text('Reload '),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  ListView buildShowListEmp() {
    var id = '';
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: userShowListModel.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShowTitle(
                title: userShowListModel[index].name.toString(),
                textStyle: MyConstant().h3style(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ShowTitle(
              title: userShowListModel[index].surname.toString(),
              textStyle: MyConstant().h3style(),
            ),
          ),
          Expanded(
            flex: 3,
            child: ShowTitle(
              title: userShowListModel[index].phone.toString(),
              textStyle: MyConstant().h3style(),
            ),
          ),
          Expanded(
            //ปุ่ม Edit
            child: IconButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditProfileCustomer(
                        userShowListModel: userShowListModel[index]);
                  }));
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.red.shade700,
                )),
          ),
          Expanded(
            //ปุ่ม Delete
            child: IconButton(
                onPressed: () async {
                  confirmDelete(userShowListModel[index]);
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red.shade700,
                )),
          ),
        ],
      ),
    );
  }
}

Divider buildDivider() {
  return Divider(
    color: MyConstant.dark,
  );
}

Container buildHead() {
  return Container(
    decoration: BoxDecoration(color: MyConstant.light),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShowTitle(
                title: 'ชื่อ  ',
                textStyle: MyConstant().h2style(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ShowTitle(
              title: 'นามสกุล ',
              textStyle: MyConstant().h2style(),
            ),
          ),
          Expanded(
            flex: 3,
            child: ShowTitle(
              title: 'เบอร์โทร ',
              textStyle: MyConstant().h2style(),
            ),
          ),
        ],
      ),
    ),
  );
}
