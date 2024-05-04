import 'package:another_flushbar/flushbar.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

void showCustomSnackbar(BuildContext context, String message){
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

Future<XFile?> selectImage() async{
  XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  return selectedImage;
}