import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:suara_mawa/screens/aspirasi/aspirasi_main_screen.dart';
import 'package:suara_mawa/screens/auth/index.dart';
import 'package:suara_mawa/screens/penindak/penindak_main_screen.dart';
import 'package:suara_mawa/utils/local_notif.dart';
import 'package:suara_mawa/utils/user_controller.dart';

class AuthService {
  static const String baseUrl = String.fromEnvironment(
    'SERVER_BASE_URL',
    defaultValue: '',
  );

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"ngrok-skip-browser-warning": "69420"},
    ),
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<(bool, String)> checkAuth(WidgetRef ref) async {
    try {
      String? token = await getToken();
      if (token == null) {
        var (email, pw) = await this.getEmailPw();
        if (email == null) {
          return (false, 'UNAUTHORIZED');
        }
        var (result, code) = await signInEmail(email, pw!);
        if (!result) return (result, code ?? 'unknown');
        token = code;
      } // langsung ke dashboard

      final response = await _dio.get(
        '/user/check',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final user = User.fromJson(response.data);
      ref
          .read(userControllerProvider.notifier)
          .update(
            UserModel(
              user: user,
              token: token,
              mahasiswaDetail: user.userRole?.name == "MAHASISWA"
                  ? MahasiswaDetail.fromJson(response.data['mahasiswaDetail'])
                  : null,
              penindakDetail: user.userRole?.name == "PENINDAK"
                  ? PenindakDetail.fromJson(response.data['penindakDetail'])
                  : null,
              adminDetail: user.userRole?.name == "ADMIN"
                  ? AdminDetail.fromJson(response.data['adminDetail'])
                  : null,
            ),
          );
      print("Success, : ${ref.read(userControllerProvider).user?.name}");
      return (true, 'success');
    } on DioException catch (e) {
      print(e.response.toString());
      return (false, e.response?.data['code'].toString() ?? '');
    }
  }

  Future<(bool, String?)> signInGoogle() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;
      print("Running");
      await signIn.initialize(
        serverClientId: const String.fromEnvironment(
          'GOOGLE_MOBILE_ID',
          defaultValue: '',
        ),
      );

      final GoogleSignInAccount user = await signIn.authenticate();

      final auth = user.authentication;

      final idToken = auth.idToken;

      if (idToken == null) {
        throw Exception("Google ID Token tidak ditemukan");
      }

      final response = await _dio.post(
        "/api/auth/sign-in/social",
        data: {
          "provider": "google",
          "idToken": {"token": idToken},
        },
      );

      final data = response.data;
      print("Data: $data");
      final token = data["token"];
      final userRoleId = data["user"]?["userRoleId"];

      if (token != null) {
        await _storage.write(key: "auth_token", value: token);
      }
      if (userRoleId != null) {
        await _storage.write(key: "userRoleId", value: userRoleId.toString());
      }

      return (true, token.toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    } catch (e) {
      throw Exception("Exception" + e.toString());
    }
  }

  Future<(bool, String?)> signInEmail(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/auth/sign-in/email',
        data: {'email': email, 'password': password},
      );
      print("Data: ${response.data}"); // Dio automatically decodes JSON
      final data = response.data;

      final token = data["token"];
      final userRoleId = data["user"]?["userRoleId"];
      if (token != null) {
        await _storage.write(key: "auth_token", value: token);
      }
      if (userRoleId != null) {
        await _storage.write(key: "userRoleId", value: userRoleId.toString());
      }
      return (true, token.toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<(bool, String?)> signUpEmail(
    String email,
    String fullName,
    String password,
  ) async {
    try {
      print("Sogn Up email");
      final response = await _dio.post(
        '/api/auth/sign-up/email',
        data: {'email': email, 'name': fullName, 'password': password},
      );
      print(response);
      final data = response.data;
      final isSuccess = data["user"] != null;
      if (isSuccess) {
        saveEmailPw(email, password);
      }
      return (isSuccess, isSuccess ? "success" : data["message"].toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<(bool, String?)> appendNIM(String nim) async {
    try {
      final token = await this.getToken();
      final response = await _dio.post(
        '/user/mahasiswa-detail',
        data: {'nim': nim},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = response.data;
      print(response);
      final isSuccess = data["message"] == 'Success';
      return (isSuccess, isSuccess ? "Success" : data["message"].toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<(bool, String?)> appendNomorHP(String nomorHp) async {
    try {
      final token = await this.getToken();
      final response = await _dio.post(
        '/user/phone-number',
        data: {'phoneNumber': nomorHp},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = response.data;
      print(data);
      final isSuccess = data["message"] == 'success';
      return (isSuccess, isSuccess ? "success" : data["message"].toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<void> logout(WidgetRef ref) async {
    await _storage.deleteAll();
    ref.read(userControllerProvider.notifier).destroy();
  }

  Future<String?> getToken() async {
    return _storage.read(key: "auth_token");
  }

  Future<void> saveEmailPw(String email, String pw) async {
    await _storage.write(key: "email", value: email);
    await _storage.write(key: "password", value: pw);
  }

  Future<(String?, String?)> getEmailPw() async {
    return (
      await _storage.read(key: "email"),
      await _storage.read(key: "password"),
    );
  }

  Future<(bool, String?)> askEmailVerif(String email, String password) async {
    try {
      print("Running, data $email $password");
      final response = await _dio.post(
        '/api/auth/send-verification-email',
        data: {
          'email': email,
          'password': password,
          'callbackURL': '$baseUrl/email-verified',
        },
      );
      final data = response.data;
      final isSuccess = data["message"] != null;
      return (isSuccess, isSuccess ? "success" : data["message"].toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<(bool, String?)> askPhoneVerif() async {
    try {
      final token = await this.getToken();
      final response = await _dio.get(
        '/user/phone-number/send-otp',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = response.data;
      print('Data from ask verification: $data');
      final isSuccess = data["message"] == 'code sent';
      return (isSuccess, isSuccess ? "success" : data["message"].toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<(bool, String?)> verifyPhone(String code) async {
    try {
      final token = await this.getToken();
      final user = await this.getUser();
      if (user == null) {
        return (false, "UNAUTHORIZED");
      }
      print("user exist");
      final response = await _dio.post(
        '/api/auth/phone-number/verify',
        data: {'code': code, 'phoneNumber': user.phoneNumber},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      final data = response.data;
      final isSuccess = data["message"] != 'code sent';
      return (isSuccess, isSuccess ? "success" : data["message"].toString());
    } on DioException catch (e) {
      return (false, e.response?.data['code'].toString());
    }
  }

  Future<User?> getUser() async {
    try {
      final token = await this.getToken();
      print('sending, token: $token');
      final response = await _dio.get(
        '/user/get-data',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      final data = response.data;
      final userData = data['data'] ?? data['user'] ?? data;
      final user = User.fromJson(userData);
      return user;
    } on DioException catch (e) {
      print(e.toString());
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> sendChangePassword(String currentPw, String newPw) async {
    try {
      final token = await this.getToken();
      final response = await _dio.post(
        '/api/auth/phone-number/verify',
        data: {
          'newPassword': newPw,
          'currentPassword': currentPw,
          "revokeOtherSessions": true,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data['token'] != null) {
        await _storage.write(key: "auth_token", value: response.data['token']);
      }
      return true;
    } on DioException catch (e) {
      // Sttaus 400 bad request
      // {
      //     "message": "Invalid password",
      //     "code": "INVALID_PASSWORD"
      // }
      if (e.response?.data['code']);
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>?> getMahasiswaDetail() async {
    try {
      final token = await this.getToken();
      print('sending, token: $token');
      final response = await _dio.get(
        '/user/mahasiswa-detail',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      return response.data['status'] == 'success'
          ? response.data['data']
          : null;
    } on DioException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> updatePassword(
    String newPassoword,
    String currentPassword,
  ) async {
    try {
      final token = await this.getToken();
      final response = await _dio.get(
        '/api/auth/change-password',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"newPassword": newPassoword, "currentPassword": currentPassword},
      );
      return true;
    } on DioException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> sendFCMToken() async {
    try {
      final token = await this.getToken();
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      // 1. Request izin (khusus Android 13+)
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(alert: true, badge: true, sound: true);

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User mengizinkan notifikasi');

        // 2. Ambil FCM Token (Kirim token ini ke server Anda untuk target spesifik)
        String? FCMToken = await _firebaseMessaging.getToken();
        print("FCM Token Anda: $FCMToken");
        if (FCMToken == null) return false;
        final response = await _dio.post(
          '/notification/register',
          data: {'token': FCMToken},
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        // 3. Handle notifikasi saat aplikasi aktif (Foreground)
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void HandleError(
    String code,
    BuildContext context, {
    String? email,
    String? password,
  }) async {
    print(code);
    switch (code) {
      case "EMAIL_NOT_VERIFIED":
        var (em, pw) = await getEmailPw();
        if (email != null) {
          saveEmailPw(email, password!);
        } else if (em == null) {
          print("Errorrrrr");
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerifyEmailPage()),
        );
        break;
      case "UNAUTHORIZED":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        break;
      case "EMPTY_MAHASISWA_DETAIL":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NimPage()),
        );
        break;
      case "EMPTY_PENINDAK_DETAIL":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NimPage()),
        );
        break;
      case "INVALID_USER_ROLE":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NimPage()),
        );
        break;
      case "EMPTY_PHONE_NUMBER":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PhonePage()),
        );
        break;
      case "UNVERIFIED_PHONE_NUMBER":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PhoneVerifyPage()),
        );
        break;
      case "SUCCESS":
        final userRoleIdStr = await _storage.read(key: "userRoleId");
        int? userRoleId = int.tryParse(userRoleIdStr ?? '');
        await sendFCMToken();
        if (!context.mounted) return;
        if (userRoleId == null) {
          final user = await getUser();
          userRoleId = user?.userRoleId;
        }

        if (userRoleId == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PenindakMainScreen()),
          );
        } else if (userRoleId == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AspirasiMainScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }
        break;
      default:
        break;
    }
  }
}
