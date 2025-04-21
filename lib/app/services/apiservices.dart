import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Multipart için gerekli

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

    bool contentTypemultiform = false,
  }) async {
    try {
      // URL oluştur
      Uri url =
          Uri.parse("$baseUrl$endpoint").replace(queryParameters: queryParams);

      // Varsayılan başlıklar
      headers ??= {};
      headers.addAll({
        "Content-Type":
            contentTypemultiform ? 'multipart/form-data' : "application/json",
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

  // Kullanıcı giriş fonksiyonu (Login)
  Future<http.Response?> register2({
    required String username,
    required String mail,
    required String password,
    required File? avatar, // Avatar olarak bir dosya
    required String birthDate, // ISO 8601 format
  }) async {
    if (avatar == null) {
      log('avatar secilmedi');
      return null;
    }

    var response = await request(
      method: "POST",
      endpoint: "/users/Register",
      data: {
        "username": username,
        "Mail": mail,
        "Password": password,
        "Avatar": avatar.path,
        "BirthDate": birthDate,
        "ConsentsJson": jsonEncode({"privacy": true})
      },
      contentTypemultiform: true,
    );

    if (response != null && response.statusCode == 200) {
      print(response.body.toString());
      return response;
    }
    print("Giriş başarısız!");
    return response;
  }

  // Kullanıcı kayıt fonksiyonu (Register) dosya yükleme ile
  Future<http.Response?> register({
    required String username,
    required String mail,
    required String password,
    required File avatar, // Avatar olarak bir dosya
    required String birthDate, // ISO 8601 format
    required String consentsJson, // JSON string
  }) async {
    var uri = Uri.parse("$baseUrl/users/register"); // Register endpointi

    var request = http.MultipartRequest("POST", uri)
      ..fields['username'] = username
      ..fields['mail'] = mail
      ..fields['password'] = password
      ..fields['birthDate'] = birthDate
      ..fields['consentsJson'] = consentsJson;

    // Avatar dosyasını multipart olarak ekle
    var avatarFile = await http.MultipartFile.fromPath(
      'avatar', // Parametre adı (API'ye göre değişebilir)
      avatar.path,
      contentType: MediaType('image', 'jpeg'), // İçerik tipi (jpeg veya png)
    );

    request.files.add(avatarFile);

    var response = await request.send(); // İstek gönder

    // Yanıtı al
    var responseData = await http.Response.fromStream(response);
    print("Durum Kodu: ${responseData.statusCode}");
    print("Yanıt: ${responseData.body}");

    return responseData;
  }

  // Kullanıcı bilgilerini getirme fonksiyonu
  Future<http.Response?> userInfo() async {
    var response = await request(
      method: "GET",
      endpoint: "/users",
    );

    return response;
  }
}
