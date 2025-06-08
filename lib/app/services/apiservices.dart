import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:gameshowcase/app/applist.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // Multipart için gerekli

class RestApiService {
  final String baseUrl = "http://185.93.68.107/api"; // Sabit Host Adresi
  // Token set edici (setter)

  // HTTP isteği yapan fonksiyon
  Future<http.Response?> request({
    required String method, // GET, POST, PUT, DELETE
    required String endpoint, // API endpoint (ör: "/users/login")
    Map<String, dynamic>? data, // JSON body
    Map<String, String>? headers, // HTTP başlıkları (Opsiyonel)
    Map<String, String>? queryParams, // URL parametreleri (Opsiyonel)
    Map<XFile, String>? file,
    String? accessToken,
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

      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }
      if (Applist.currentuser != null) {
        headers["Authorization"] = "Bearer ${Applist.currentuser!.token}";
      }

      http.Response response;

      // Dosya varsa (POST veya PUT için MultipartRequest)
      if (file != null &&
          (method.toUpperCase() == "POST" || method.toUpperCase() == "PUT")) {
        var mpHeaders = {
          'accept': 'text/plain',
          'Language-Id': 'tr',
        };
        if (accessToken != null) {
          mpHeaders["Authorization"] = "Bearer $accessToken";
        }
        if (Applist.currentuser != null) {
          mpHeaders["Authorization"] = "Bearer ${Applist.currentuser!.token}";
        }

        var request = http.MultipartRequest(
          method.toUpperCase(), // POST veya PUT
          url,
        );

        // Body'yi ekle
        if (data != null) {
          for (var key in data.keys) {
            request.fields[key] = data[key].toString();
          }
        }

        final fileBytes = await file.keys.first.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            file.values.first, // Alan adı (örneğin, "Banner")
            fileBytes,
            filename: "banner.jpg", // Dosya adı banner olarak
          ),
        );

        request.headers.addAll(mpHeaders);

        http.StreamedResponse streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Dosya yoksa normal HTTP isteği
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
      }

      if (kDebugMode) {
        print("Durum Kodu: ${response.statusCode}");
        print("Yanıt: ${response.body}");
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print("API Hatası: $e");
      }
      return null;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////
  ///news baslangıc
  Future<http.Response?> newsDetail({required int id}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/$id",
      queryParams: {},
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }

    return response;
  }

///////////////////////////////////////////////////////////////////////////////////////////
  Future<http.Response?> newsList({required int page}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/Search",
      queryParams: {
        "Type": "news",
        "orderbycolumnname": "CreatedDate",
        "ordertype": "desc",
        "PageNumber": "$page",
        "pagesize": "10",
      },
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }

    return response;
  }

  // /////////////////////////////////////////////////////////////////////////////////////////

  Future<http.Response?> newsListToPanel({required int page}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/SearchForPanel",
      queryParams: {
        "Type": "news",
        "orderbycolumnname": "CreatedDate",
        "ordertype": "desc",
        "PageNumber": "$page",
        "pagesize": "10",
      },
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }
    if (kDebugMode) {
      print("Giriş başarısız!");
    }
    return response;
  }

///////////////////////////////////////////////////////////////////////////////////////////

  Future<http.Response?> newsRemove({
    required int id,
  }) async {
    var response = await request(
      method: "DELETE",
      endpoint: "/Contents/$id",
    );

    if (response != null && response.statusCode == 204) {
      return response;
    }
    if (kDebugMode) {
      print("haber silinemedi!");
      print(response);
    }
    return response;
  }

  Future<http.Response?> newsEdit({
    required String name,
    required String title,
    required String text,
    required int id,
  }) async {
    var response = await request(
      method: "PUT",
      endpoint: "/Contents",
      data: {
        "id": id,
        "name": name,
        "rank": 0,
        "youtubeUrl": "string",
        "state": "Active",
        // "title": '{"tr": "$title", "en": "$title"}',
        // "text": '{"tr": "$text", "en": "$text"}',
        "title": {
          "tr": title,
          "en": title,
        },
        "text": {
          "tr": text,
          "en": text,
        },
      },
    );

    if (kDebugMode) {
      print("newsEdit Durum Kodu: ${response?.statusCode}");
      print("newsEdit Yanıt: ${response?.body}");
    }

    return response;
  }

  Future<http.Response?> newsAdd({
    required String name,
    required String title,
    required String text,
    required XFile banner,
  }) async {
    var response = await request(
      method: "POST",
      endpoint: "/Contents",
      file: {banner: "Banner"},
      data: {
        "Name": name,
        "TitleJson": '{"tr": "$title", "en": "$title"}',
        "TextJson": '{"tr": "$text", "en": "$text"}',
        "Type": "news",
      },
    );

    if (response != null && response.statusCode == 201) {
      return response;
    }
    if (kDebugMode) {
      print("haber eklenemedi!");
      print(response);
    }
    return response;
  }

  ///news sonu

  /////////////////////////////////////////////////////////////////////////////////////////////
  /////event baslangic
  Future<http.Response?> eventsDetail({required int id}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/$id",
      queryParams: {},
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }

    return response;
  }

///////////////////////////////////////////////////////////////////////////////////////////

  Future<http.Response?> eventList({required int page}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/Search",
      queryParams: {
        "Type": "event",
        "orderbycolumnname": "CreatedDate",
        "ordertype": "desc",
        "PageNumber": "$page",
        "pagesize": "10",
      },
    );

    if (response != null && response.statusCode == 200) {
      log("Response Body: ${response.body}");
      return response;
    }

    return response;
  }

  // /////////////////////////////////////////////////////////////////////////////////////////

  Future<http.Response?> eventsListToPanel({required int page}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/SearchForPanel",
      queryParams: {
        "Type": "Event",
        "orderbycolumnname": "CreatedDate",
        "ordertype": "desc",
        "PageNumber": "$page",
        "pagesize": "10",
      },
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }
    if (kDebugMode) {
      print("Giriş başarısız!");
    }
    return response;
  }

///////////////////////////////////////////////////////////////////////////////////////////
  Future<http.Response?> eventsAdd(
      {required String name,
      required String title,
      required String text,
      required XFile banner,
      required String youtubeUrl}) async {
    var response = await request(
      method: "POST",
      endpoint: "/Contents",
      file: {banner: "Banner"},
      data: {
        "Name": name,
        "TitleJson": '{"tr": "$title", "en": "$title"}',
        "TextJson": '{"tr": "$text", "en": "$text"}',
        "Type": "Event",
        "YoutubeUrl": youtubeUrl
      },
    );

    if (response != null && response.statusCode == 201) {
      return response;
    }
    if (kDebugMode) {
      print("etkinlik eklenemedi!");
      print(response);
    }
    return response;
  }
  /////////////////////////////////////////

  Future<http.Response?> eventsRemove({
    required int id,
  }) async {
    var response = await request(
      method: "DELETE",
      endpoint: "/Contents/$id",
    );

    if (response != null && response.statusCode == 204) {
      return response;
    }
    if (kDebugMode) {
      print("haber silinemedi!");
      print(response);
    }
    return response;
  }

  Future<http.Response?> eventsEdit({
    required String name,
    required String title,
    required String text,
    required int id,
  }) async {
    var response = await request(
      method: "PUT",
      endpoint: "/Contents",
      data: {
        "id": id,
        "name": name,
        "rank": 0,
        "youtubeUrl": "string",
        "state": "Active",
        // "title": '{"tr": "$title", "en": "$title"}',
        // "text": '{"tr": "$text", "en": "$text"}',
        "title": {
          "tr": title,
          "en": title,
        },
        "text": {
          "tr": text,
          "en": text,
        },
      },
    );

    if (kDebugMode) {
      print("newsEdit Durum Kodu: ${response?.statusCode}");
      print("newsEdit Yanıt: ${response?.body}");
    }

    return response;
  }
  //////event sonu

  /////////////////////////////////////////////////////////////////////////////////////////////
  /////update baslangic
  Future<http.Response?> updateDetail({required int id}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/$id",
      queryParams: {},
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }

    return response;
  }

///////////////////////////////////////////////////////////////////////////////////////////
  ///haber listeleme
  Future<http.Response?> updateList({required int page}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/Search",
      queryParams: {
        "Type": "update",
        "orderbycolumnname": "CreatedDate",
        "ordertype": "desc",
        "PageNumber": "$page",
        "pagesize": "10",
      },
    );

    if (response != null && response.statusCode == 200) {
      log("Response Body: ${response.body}");
      return response;
    }

    return response;
  }

  // /////////////////////////////////////////////////////////////////////////////////////////

  Future<http.Response?> updateListToPanel({required int page}) async {
    var response = await request(
      method: "GET",
      endpoint: "/Contents/SearchForPanel",
      queryParams: {
        "Type": "Update",
        "orderbycolumnname": "CreatedDate",
        "ordertype": "desc",
        "PageNumber": "$page",
        "pagesize": "10",
      },
    );

    if (response != null && response.statusCode == 200) {
      return response;
    }
    if (kDebugMode) {
      print("Giriş başarısız!");
    }
    return response;
  }

///////////////////////////////////////////////////////////////////////////////////////////
  Future<http.Response?> updateAdd(
      {required String name,
      required String title,
      required String text,
      required XFile banner,
      required String youtubeUrl}) async {
    var response = await request(
      method: "POST",
      endpoint: "/Contents",
      file: {banner: "Banner"},
      data: {
        "Name": name,
        "TitleJson": '{"tr": "$title", "en": "$title"}',
        "TextJson": '{"tr": "$text", "en": "$text"}',
        "Type": "Update",
        "YoutubeUrl": youtubeUrl
      },
    );

    if (response != null && response.statusCode == 201) {
      return response;
    }
    if (kDebugMode) {
      print("guncelleme eklenemedi!");
      print(response);
    }
    return response;
  }

  Future<http.Response?> updateRemove({
    required int id,
  }) async {
    var response = await request(
      method: "DELETE",
      endpoint: "/Contents/$id",
    );

    if (response != null && response.statusCode == 204) {
      return response;
    }
    if (kDebugMode) {
      print("guncelleme silinemedi!");
      print(response);
    }
    return response;
  }

  Future<http.Response?> updateEdit({
    required String name,
    required String title,
    required String text,
    required int id,
    required String youtubeUrl,
  }) async {
    var response = await request(
      method: "PUT",
      endpoint: "/Contents",
      data: {
        "id": id,
        "name": name,
        "rank": 0,
        "youtubeUrl": youtubeUrl,
        "state": "Active",
        "title": {
          "tr": title,
          "en": title,
        },
        "text": {
          "tr": text,
          "en": text,
        },
      },
    );

    if (kDebugMode) {
      print("newsEdit Durum Kodu: ${response?.statusCode}");
      print("newsEdit Yanıt: ${response?.body}");
    }

    return response;
  }

  //////update sonu

  // Kullanıcı giriş fonksiyonu (Login)
  Future<http.Response?> login(String username, String password) async {
    var response = await request(
      method: "POST",
      endpoint: "/users/login",
      data: {"username": username, "password": password},
    );

    if (response != null && response.statusCode == 200) {
      if (kDebugMode) {
        print("Giriş başarılı, token kaydedildi!");
      }
      return response;
    }
    if (kDebugMode) {
      print("Giriş başarısız!");
    }
    return response;
  }

  // Kullanıcı giriş fonksiyonu (Login)
  Future<http.Response?> register({
    required String username,
    required String mail,
    required String password,
    required XFile? avatar, // Avatar olarak bir dosya
    required String birthDate, // ISO 8601 format
  }) async {
    if (avatar == null) {
      log('avatar secilmedi');
      return null;
    }

    var response = await request(
      method: "POST",
      endpoint: "/users/Register",
      file: {avatar: "Avatar"},
      data: {
        "username": username,
        "Mail": mail,
        "Password": password,
        "BirthDate": birthDate,
      },
    );

    if (response != null && response.statusCode == 200) {
      print(response.body.toString());
      return response;
    }
    log(response?.body.toString() ?? "null");
    return response;
  }

  // Kullanıcı bilgilerini getirme fonksiyonu
  Future<http.Response?> userInfo(String accesstoken) async {
    var response = await request(
      method: "GET",
      endpoint: "/users",
      accessToken: accesstoken,
    );

    return response;
  }
}
