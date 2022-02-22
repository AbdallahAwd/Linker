import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linker/app/modules/add/models/model.dart';

class SearchController extends GetxController {
  var searchList = [].obs;
  var searchListId = <String>[].obs;
  var storage = GetStorage();
  var searchController = TextEditingController();

  void search(searchtxt) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(storage.read('uId'))
        .collection('Links')
        .where("title", isNotEqualTo: searchtxt)
        .orderBy("title")
        .startAt([
          searchtxt,
        ])
        .endAt([
          searchtxt + '\uf8ff',
        ])
        .snapshots()
        .listen((event) {
          searchList.value = [];
          searchListId.value = [];
          for (var element in event.docs) {
            searchList.add(AddLinkModel.fromJson(element.data()));
            searchListId.add(element.id);
          }
        });
  }

  void searchDelete(itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(storage.read('uId'))
          .collection('Links')
          .doc(itemId)
          .delete();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void clear() {
    searchList.value = [];
    searchController.clear();
  }
}
