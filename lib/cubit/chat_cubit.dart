import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frt/application_complete/snackbar1.dart';
import 'package:frt/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  Future<bool> loginne({
    required String email,
    required String password,
  }) async {
    emit(loading());
    try {
      UserCredential usere = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(succes());
      return true;
    } on FirebaseAuthException catch (e) {
      // showSnackuBar(context, "ERROr:${e.code}");
      if (e.code == 'invalid-credential') {
        //  showSnackBar(context, 'email ou password invalid');
        emit(exception(error: 'email ou password invalid'));
      }
      return false;
    } catch (ex) {
      emit(exception(error: 'nothing'));
      //showSnackBar(context, 'error');
      return false;
    }
  }
}
