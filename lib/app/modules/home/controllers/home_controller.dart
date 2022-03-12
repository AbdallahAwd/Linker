// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linker/app/modules/add/models/model.dart';
import 'package:linker/app/modules/home/views/favorites.dart';
import 'package:linker/app/modules/home/views/links.dart';
import 'package:linker/app/modules/home/views/settings.dart';
import 'package:linker/app/modules/on_boarding/models/user_model.dart';

import '../../../components/component.dart';
import '../views/auth.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;
  var storage = GetStorage();
  var colorIndex = 0.obs;
  var appBarTitle = <String>[
    'Links',
    'Favorites',
    'Authentication',
    'Settings',
  ].obs;
  var screens = <Widget>[
    const Links(),
    Favorites(),
    const Private(),
    const SettingsApp(),
  ].obs;
  Themess theme = Themess.FollowSystem;
  List<String> darkMode = [
    'Follow System',
    'Dark Mode',
    'Light Mode',
  ];
  void changeTheme(Themess value) {
    theme = value;
    update();
  }

  List<UserModel> user = [];

  var linkList = <AddLinkModel>[].obs;
  List<String> itemId = [];
  void listenToData() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Links')
          .orderBy(
            'time',
          )
          .snapshots()
          .listen((event) {
        linkList.value = [];
        itemId = [];
        for (var element in event.docs) {
          linkList.add(AddLinkModel.fromJson(element.data()));
          itemId.add(element.id);
        }
      });
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void deleteItem(String itemId) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Links')
          .doc(itemId)
          .delete();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  UserModel? userModel;
  void userData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(storage.read('uId'))
        .snapshots()
        .listen((value) {
      userModel = UserModel.fromJson(value.data()!);
    });
  }

  FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;

  @override
  void onInit() {
    listenToData();
    userData();
    fiam.setAutomaticDataCollectionEnabled(true);
    fiam.setMessagesSuppressed(true);
    super.onInit();
  }
}
