import 'package:local_auth/local_auth.dart';
// implementation 'com.google.firebase:firebase-analytics'

class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static Future<bool> authenticate() async {
    final isAvalible = await hasFingerPrint();
    if (!isAvalible) return false;
    try {
      return await _auth.authenticate(
          localizedReason: 'Scan Finger Print to Authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          sensitiveTransaction: true);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> hasFingerPrint() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }
}
