import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordViewModel{

  recuperarSenha(String email)async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuth catch (e){
      // TODO: fazer tratamento de erro
      print(e);
    }
  }

}