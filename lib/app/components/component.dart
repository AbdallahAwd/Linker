// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linker/app/themes/colors.dart';

Widget defaultTextFormFeild({
  required TextEditingController controller,
  required IconData pre,
  required String hintText,
  FormFieldValidator<String>? validate,
  var onChange,
  IconData? suff,
  var suffixWidget,
  bool isObscure = false,
  required var keyType,
  var suffPress,
  var submit,
  bool enable = true,
}) =>
    TextFormField(
      enabled: enable,
      keyboardType: keyType,
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      maxLines: 1,
      onFieldSubmitted: submit,
      decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(
            pre,
            color: mainColor,
          ),
          suffix: suffixWidget,
          suffixIcon: IconButton(
            onPressed: suffPress,
            icon: Icon(suff),
            color: mainColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: mainColor)),
          focusColor: mainColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: mainColor)),
          labelText: hintText,
          labelStyle: const TextStyle(color: mainColor)),
      validator: validate,
    );
Future toast({
  required String text,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

Widget mainText(context, {required String text, double fontsize = 18}) => Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: fontsize,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

enum Themess { FollowSystem, DarkMode, LightMode }
