import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/models/user_model.dart';
import 'package:flutter_test1/models/user_showlist_model.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:flutter_test1/widgets/show_image.dart';
import 'package:flutter_test1/widgets/show_progress.dart';
import 'package:flutter_test1/widgets/show_title.dart';
//import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileCustomer extends StatefulWidget {
  final UserShowListModel userShowListModel;
  const EditProfileCustomer({Key? key, required this.userShowListModel})
      : super(key: key);

  @override
  State<EditProfileCustomer> createState() => _EditProfileCustomerState();
}

class _EditProfileCustomerState extends State<EditProfileCustomer> {
  UserShowListModel? userShowListModel;
  //UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? file;
  @override
  void initState() {
    // TODO: implement initState

    userShowListModel = widget.userShowListModel;
    print(userShowListModel);
    findUser();
    super.initState();
  }

  Future<Null> findUser() async {
    setState(() {
      nameController.text = userShowListModel!.name;
      surnameController.text = userShowListModel!.surname;
      addressController.text = userShowListModel!.address;
      phoneController.text = userShowListModel!.phone;
      emailController.text = userShowListModel!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เเก้ไขโปรไฟล์ '),
        // actions: [
        //   IconButton(
        //     onPressed: () => processEditProfileCustomer(),
        //     icon: Icon(Icons.edit),
        //     tooltip: 'เเก้ไข โปรไฟล์',
        //   ),
        // ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: (() => FocusScope.of(context).requestFocus(
                FocusNode(),
              )),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                BuildTitle('Geneal:'),
                buildName(constraints),
                buildSurName(constraints),
                buildAddress(constraints),
                buildPhone(constraints),
                buildEmail(constraints),
                SizedBox(height: 15),
                BuildTitle('Avatar :'),
                buildAvatar(constraints),
                buildButtonEditProfile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> processEditProfileCustomer() async {
    // MyDialog().showProgressDialog(context);
    if (formKey.currentState!.validate()) {
      if (file == null) {
        print('####> ใช้รูปภาพเดิม');
        editValueToMySQL(userShowListModel!.pic_members);
      } else {
        String apiSaveAvatar = '${MyConstant.domain}/boneclinic/saveAvatar.php';

        List<String> nameAvatars = userShowListModel!.pic_members.split('/');
        String nameFile = nameAvatars[nameAvatars.length - 1];
        nameFile = 'edit${Random().nextInt(100)}$nameFile';
        print('####> ใช้รูปภาพใหม่ $nameFile');

        Map<String, dynamic> map = {};
        map['file'] =
            await MultipartFile.fromFile(file!.path, filename: nameFile);
        FormData formData = FormData.fromMap(map);
        await Dio().post(apiSaveAvatar, data: formData).then((value) {
          print('Upload Succes');
          String pathAvatar = '/boneclinic/avatar/$nameFile';
          editValueToMySQL(pathAvatar);
        });
      }
    }
  }

  Future<Null> editValueToMySQL(String pathAvatar) async {
    print('## pathAvatar ==> $pathAvatar');
    String apiEditProfile =
        '${MyConstant.domain}/boneclinic/editProfileCustomerWhereId.php?isAdd=true&id=${userShowListModel!.members_id}&name=${nameController.text}&surname=${surnameController.text}&address=${addressController.text}&phone=${phoneController.text}&email=${emailController.text}&pic_members=$pathAvatar';
    await Dio().get(apiEditProfile).then((value) {
      print('$apiEditProfile');
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  ElevatedButton buildButtonEditProfile() {
    return ElevatedButton.icon(
      onPressed: () => processEditProfileCustomer(),
      icon: Icon(Icons.edit),
      label: Text('Edit Profile '),
    );
  }

  Future<Null> createAvatar({ImageSource? source}) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source!, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          // decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              IconButton(
                onPressed: () => createAvatar(source: ImageSource.camera),
                icon: Icon(
                  Icons.add_a_photo,
                  color: MyConstant.dark,
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.6,
                height: constraints.maxWidth * 0.6,
                child: userShowListModel == null
                    ? showProgress()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: userShowListModel!.pic_members.isEmpty
                            ? ShowImage(path: MyConstant.avatar)
                            : file == null
                                ? buildShowImageNetwork()
                                : Image.file(file!),
                      ),
              ),
              IconButton(
                onPressed: () => createAvatar(source: ImageSource.gallery),
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: MyConstant.dark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  CachedNetworkImage buildShowImageNetwork() {
    return CachedNetworkImage(
      imageUrl: '${MyConstant.domain}${userShowListModel!.pic_members}',
      placeholder: (context, url) => showProgress(),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Name';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSurName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Surname';
              } else {
                return null;
              }
            },
            controller: surnameController,
            decoration: InputDecoration(
              labelText: 'Surname : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Address';
              } else {
                return null;
              }
            },
            maxLines: 3,
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Phone';
              } else {
                return null;
              }
            },
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEmail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Email';
              } else {
                return null;
              }
            },
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'E-mail : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  ShowTitle BuildTitle(String title) {
    return ShowTitle(
      title: title,
      textStyle: MyConstant().h2style(),
    );
  }
}
