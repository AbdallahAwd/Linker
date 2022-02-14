// ignore_for_file: constant_identifier_names

import 'package:animator/animator.dart';
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
            color: const Color.fromARGB(255, 98, 0, 238),
          ),
          suffix: suffixWidget,
          suffixIcon: IconButton(onPressed: suffPress, icon: Icon(suff)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: mainColor)),
          focusColor: mainColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: mainColor)),
          labelText: hintText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 98, 0, 238))),
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

Widget mainText(context, {required String text, double fontsize = 18}) =>
    Text(text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: fontsize,
            ));

enum Themess { FollowSystem, DarkMode, LightMode }

Widget animateIcon(context,
    {required IconData icon,
    Curve curve = Curves.easeInOut,
    int scale = 5,
    double begin = 3,
    double end = 6,
    Color color = Colors.white}) {
  double _width = MediaQuery.of(context).size.width;
  // scale = 5;
  return Center(
    child: SizedBox(
      height: _width / 2.7,
      width: _width / 2.7,
      child: Animator<double>(
        duration: const Duration(milliseconds: 1000),
        cycles: 0,
        curve: curve,
        tween: Tween<double>(begin: begin, end: end),
        builder: (context, animatorState, child) => Icon(
          icon,
          size: animatorState.value * scale,
          color: color,
        ),
      ),
    ),
  );
}
