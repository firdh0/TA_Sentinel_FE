import 'dart:convert';

import 'package:chat_armor/services/auth_service.dart';
import 'package:chat_armor/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class PinService{
  Future<void> updatePin(String oldPin, String newPin) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse(
          '$baseUrl/update_pin'
        ),
        body: {
          "previous_pin": oldPin,
          "new_pin": newPin
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