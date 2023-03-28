import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test1/unility/my_constant.dart';
import 'package:flutter_test1/widgets/show_image.dart';
import 'package:flutter_test1/widgets/show_title.dart';

class MyDialog {
  final Function()? funcAction;
  // final VoidCallback? onPressed;
  MyDialog({this.funcAction});

  Future<Null> showProgressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
          child: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
          onWillPop: () async {
            return false;
          }),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String messagde) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(title: title, textStyle: MyConstant().h2style()),
          subtitle:
              ShowTitle(title: messagde, textStyle: MyConstant().h3style()),
        ),
        children: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
        ],
      ),
    );
  }

  Future<Null> actionDialog(
    BuildContext context,
    String title,
    String messagde,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(title: title, textStyle: MyConstant().h2style()),
          subtitle:
              ShowTitle(title: messagde, textStyle: MyConstant().h3style()),
        ),
        actions: [
          TextButton(
            onPressed: funcAction,
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
