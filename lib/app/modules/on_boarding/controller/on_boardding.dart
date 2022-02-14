import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linker/app/modules/on_boarding/models/user_model.dart';

class OnBoardingController extends GetxController {
  var index = 0.obs;
  bool isTaped = false;
  var storage = GetStorage();
  void changeTap() {
    isTaped = true;
    update();
  }

  void changeNum(int index) {
    this.index.value = index;
  }

  String? uid;
  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogIn() async {
    try {
      final googleUser = await googleSignin.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      storage.write('uId', _user!.id);
      await FirebaseAuth.instance.signInWithCredential(credential);
      uid = _user!.id;
      update();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future logout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }

  void addUserData() {
    UserModel userModel = UserModel(
      email: _user!.email,
      image: _user!.photoUrl,
      uid: uid,
      userName: _user!.displayName,
    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userModel.toMap());
      update();
    } catch (e) {
      printError(info: e.toString());
    }
  }

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }
}
