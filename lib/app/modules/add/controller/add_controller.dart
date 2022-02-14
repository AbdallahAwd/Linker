// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/model.dart';

class AddController extends GetxController {
  var titleController = TextEditingController();
  var urlController = TextEditingController();
  var favoriteList = <AddLinkModel>[].obs;
  var favoriteItem = <String>[];
  var privateList = <AddLinkModel>[].obs;
  var privateItem = <String>[];
  var favoriteCheck = false;
  var storage = GetStorage();
  void changeFavCheck(bool val) {
    favoriteCheck = val;
    update();
  }

  var privateCheck = false;
  void changePriCheck(bool val) {
    privateCheck = val;
    update();
  }

  void addLink() {
    AddLinkModel addLink = AddLinkModel(
      isFavorite: favoriteCheck,
      isPrivate: privateCheck,
      title: titleController.text.toLowerCase(),
      url: urlController.text,
    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Links')
          .add(addLink.toMap());
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void clear() {
    titleController.clear();
    urlController.clear();
  }

  late AddLinkModel add;
  void updateLink(itemId) {
    add = AddLinkModel(
        isFavorite: favoriteCheck,
        isPrivate: privateCheck,
        title: titleController.text,
        url: urlController.text);
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Links')
          .doc(itemId)
          .update(add.toMap());
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void isFav() {
    if (favoriteCheck) {
      addToFav();
    } else {
      return;
    }
  }

  void addToFav() {
    add = AddLinkModel(
        isFavorite: favoriteCheck,
        isPrivate: privateCheck,
        title: titleController.text,
        url: urlController.text);
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Favorites')
          .add(add.toMap());
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void listenToFav() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Favorites')
          .snapshots()
          .listen((event) {
        favoriteList.value = [];
        favoriteItem = [];
        for (var element in event.docs) {
          favoriteList.add(AddLinkModel.fromJson(element.data()));
          favoriteItem.add(element.id);
        }
      });
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void favDelete(itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Favorites')
          .doc(itemId)
          .delete();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void listenToPriv() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('private')
          .snapshots()
          .listen((event) {
        privateList.value = [];
        privateItem = [];
        for (var element in event.docs) {
          privateList.add(AddLinkModel.fromJson(element.data()));
          privateItem.add(element.id);
        }
      });
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void privDelete(itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('private')
          .doc(itemId)
          .delete();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void isPrivate() {
    if (privateCheck) {
      addToPriv();
    } else {
      return;
    }
  }

  void addToPriv() {
    add = AddLinkModel(
        isFavorite: favoriteCheck,
        isPrivate: privateCheck,
        title: titleController.text,
        url: urlController.text);
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('private')
          .add(add.toMap());
    } catch (e) {
      printError(info: e.toString());
    }
  }

  @override
  void onInit() {
    listenToFav();
    listenToPriv();
    super.onInit();
  }
}
