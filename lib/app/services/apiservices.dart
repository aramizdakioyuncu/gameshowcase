import 'dart:convert';
import 'dart:developer';
import 'package:armoyu_services/core/models/ARMOYU/user.dart';
import 'package:http/http.dart' as http;

class RestApiService {
  final String baseUrl = "http://185.93.68.107/api"; // Sabit Host Adresi
  String? _token; // Özel olarak saklanan token (Encapsulation)

  // Token set edici (setter)
  void setToken(String token) {
    _token = token;
  }

  // HTTP isteği yapan fonksiyon
  Future<http.Response?> request({
    required String method, // GET, POST, PUT, DELETE
    required String endpoint, // API endpoint (ör: "/users/login")
    Map<String, dynamic>? data, // JSON body
    Map<String, String>? headers, // HTTP başlıkları (Opsiyonel)
    Map<String, String>? queryParams, // URL parametreleri (Opsiyonel)
  }) async {
    try {
      // URL oluştur
      Uri url =
          Uri.parse("$baseUrl$endpoint").replace(queryParameters: queryParams);

      // Varsayılan başlıklar
      headers ??= {};
      headers.addAll({
        "Content-Type": "application/json",
        "Language-Id": "tr", // Varsayılan dil başlığı
      });

      // Eğer token varsa, Authorization başlığına ekle
      if (_token != null) {
        headers["Authorization"] = "Bearer $_token";
      }

      http.Response response;

      if (method.toUpperCase() == "POST") {
        response =
            await http.post(url, headers: headers, body: jsonEncode(data));
      } else if (method.toUpperCase() == "GET") {
        response = await http.get(url, headers: headers);
      } else if (method.toUpperCase() == "PUT") {
        response =
            await http.put(url, headers: headers, body: jsonEncode(data));
      } else if (method.toUpperCase() == "DELETE") {
        response =
            await http.delete(url, headers: headers, body: jsonEncode(data));
      } else {
        throw Exception("Geçersiz HTTP metodu: $method");
      }

      print("Durum Kodu: ${response.statusCode}");
      print("Yanıt: ${response.body}");

      return response;
    } catch (e) {
      print("API Hatası: $e");
      return null;
    }
  }

  // Kullanıcı giriş fonksiyonu (Login)
  Future<http.Response?> login(String username, String password) async {
    var response = await request(
      method: "POST",
      endpoint: "/users/login",
      data: {"username": username, "password": password},
    );

    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      setToken(responseData["accessToken"]); // Token'ı sakla
      print("Giriş başarılı, token kaydedildi!");
      return response;
    }
    print("Giriş başarısız!");
    return response;
  }

  Future<http.Response?> UserInfo() async {
    var response = await request(
      method: "get",
      endpoint: "/users",
    );

    return response;
  }
}
