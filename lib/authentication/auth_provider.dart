import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _fb;

  AuthProvider(this._fb);
}
