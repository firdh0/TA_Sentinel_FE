import 'dart:convert';

import 'package:chat_armor/models/user_edit_form_model.dart';
import 'package:chat_armor/services/auth_service.dart';
import 'package:chat_armor/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class UserService{
  Future<void> updatedUser(UserEditFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse(
          '$baseUrl/update'
        ),
        body: data.toJson(),
        headers: {
          'Authorization': token,
        }
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse(
          '$baseUrl/update_phoneNumber'
        ),
        body: {
          "phone_number": phoneNumber,
        },
        headers: {
          'Authorization': token,
        }
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      
    }
  }
}