import 'dart:convert';

import 'package:chat_armor/models/sign_in_form_model.dart';
import 'package:chat_armor/models/sign_up_form_model.dart';
import 'package:chat_armor/models/user_model.dart';
import 'package:chat_armor/shared/shared_values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  
  Future<bool> checkEmail(String email, String username) async {
      try{
        final res = await http.post(
          Uri.parse(
            '$baseUrl/is_email_exist',
          ),

          body: {
            'email': email,
            'username': username
          },
        );

        if(res.statusCode == 200){
          final body = jsonDecode(res.body);
          return body['Email sudah ada'] || body['Username sudah ada'];
        }else{
          return jsonDecode(res.body)['errors'];
        }

      }catch(e){
        rethrow;
      }
  }

  Future<UserModel> register(SignUpFormModel data) async {

    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/register',
        ),

        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(
          password: data.password,
          phoneNumber: data.phoneNumber
        );

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(SignInFormModel data) async {

    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/login',
        ),

        body: data.toJson(),
      );

       final jsonResponse = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (jsonResponse['message'] == 'Kredensial login tidak valid') {
          throw Exception('Kredensial login tidak valid');
        }

        UserModel user = UserModel.fromJson(jsonResponse);
        user = user.copyWith(
          password: data.password,
        );

        await storeCredentialToLocal(user);
        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async{
    try {
      final token = await getToken();

      final res = await http.post(
        Uri.parse(
          '$baseUrl/logout',
        ),
        headers: {
          'Authorization': token,
        }
      );

      if (res.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }  

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      // await storage.write(key: 'phone_number', value: user.phoneNumber);

      print('success');
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {  
        final SignInFormModel data = SignInFormModel(
          email: values['email'],
          password: values['password'],
        );

        print('get user from local: ${data.toJson()}');

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer ' + value;
    }

    return token;
  }

  // Future<String> getNumber() async {
  //   String phoneNumber = '';

  //   const storage = FlutterSecureStorage();
  //   String? value = await storage.read(key: 'phone_number');

  //   if (value != null) {
  //     phoneNumber = 'Bearer ' + value;
  //   }

  //   return phoneNumber;
  // }

  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  // Future<String> startSession(String sessionName) async {
  //   var url = Uri.parse('http://34.128.66.110:3000/api/sessions/start');

  //   var requestBody = {
  //     'name': sessionName,
  //     'config': {
  //       'proxy': null,
  //       'webhooks': [
  //         {
  //           'url': 'https://cedb-2001-448a-5110-9379-c0de-9e56-a939-647.ngrok-free.app/webhook',
  //           'events': ['message', 'session.status'],
  //           'hmac': null,
  //           'retries': null,
  //           'customHeaders': null,
  //         }
  //       ],
  //     },
  //   };

  //   var response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(requestBody),
  //   );

  //   print('Status Code: ${response.statusCode}');

  //   if (response.statusCode == 201) {
  //     var responseBody = jsonDecode(response.body);
  //     print('Response Body: $responseBody');
  //     return responseBody['message'];
  //   } else {
  //     throw 'Failed to start session';
  //   }
  // }

  // Future<Uint8List> fetchQRCode() async {
  //   final url = 'http://34.128.66.110:3000/api/default/auth/qr?format=image';

  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200 && response.headers['content-type']!.contains('image')) {
  //     return response.bodyBytes;
  //   } else {
  //     throw 'Failed to load QR code';
  //   }
  // }

  // Future<String> fetchPhoneNumber() async {
  //   final url = 'http://34.128.66.110:3000/api/sessions/default';

  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final responseBody = json.decode(response.body);
  //     if (responseBody['status'] == 'WORKING') {
  //       var phoneNumber = responseBody['me']['id'];
  //       phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  //       phoneNumber = phoneNumber.replaceFirst('62', '0');
  //       return phoneNumber;
  //     } else {
  //       throw 'Session status is not WORKING';
  //     }
  //   } else {
  //     throw 'Failed to load phone number';
  //   }
  // }

}