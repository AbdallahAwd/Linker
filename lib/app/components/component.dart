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

defaultButton({
  required onPress,
  required String text,
  double fontSize = 20,
  Color defaultFontColor = Colors.white,
  var buttonColor,
  var icon,
  var height = 50.0,
  iconColor = Colors.white,
  var width = double.infinity,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: onPress,
        color: buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: iconColor,
              ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text.toUpperCase(),
              style: TextStyle(
                  color: defaultFontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize),
            ),
          ],
        ),
      ),
    );

Widget defaultOutLineButton({
  required onPress,
  width = double.infinity,
  height = 50.0,
  required String text,
  double borderWidth = 1.0,
  borderColor = Colors.blue,
  textColor = Colors.white,
  textFontSize = 20.0,
  icon,
  iconColor,
}) =>
    OutlinedButton.icon(
      onPressed: onPress,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor, width: borderWidth),
        minimumSize: Size(width, height),
      ),
      label: Text(
        text.toUpperCase(),
        style: TextStyle(color: textColor, fontSize: textFontSize),
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
    );

snackBar(context, {required text, color = Colors.green}) {
  var snackBar = SnackBar(
    content: Text(text),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

navigateTo(context, screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

navigateAnd(context, screen) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

defaultBottomSheet({
  required BuildContext context,
  required Widget content,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => content);
}

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
DropdownMenuItem<String> buildItems(item) {
  // Put the next line in item property
  // langItems.map(buildItems).toList()
  return DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ));
}

// Widget drop() => DropdownButton<String>(
//       value: 'item',
//       onChanged: (String? newValue) {},
//       hint: const Text('Language'),
//       items: <String>['العربيه', 'English']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
enum Themess { FollowSystem, DarkMode, LightMode }
showAlertDialog(BuildContext context,
    {required String title, required Widget content}) {
  // set up the button
  // Widget okButton = TextButton(
  //   child: Text("OK"),
  //   onPressed: () {
  //     Navigator.pop(context);
  //   },
  // );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text(title)),
    content: content,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

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
