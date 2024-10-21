import 'package:firebase_auth/firebase_auth.dart';


class Authservice{
 Future<bool> loginbyEmail({
    required String email,
    required String password,
    
  })async{
   
   try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
     ); 
     return true;
     }
     
   on Exception catch (err) {
     print(err);
     return false;
   }
  }

  Future<bool>register( {
    required String email,
    required String password,

  })async{
     try {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: email,
     password: password,
    );
    return true;
   } on Exception catch (err) {
      print(err);
      return false;
    }
     
  }
}