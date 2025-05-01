import 'package:flutter/material.dart';
import 'package:gameshowcase/app/applist.dart';
import 'package:gameshowcase/app/models/user.dart';
import 'package:get/get.dart';

class AdminRouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    ///****///

    /// Kullanıcı bilgilerini kontrol et
    final user = Applist.storage.read('user');
    if (user != null) {
      Applist.currentuser = User.fromJson(user);
    }

    ///****///

    // Eğer kullanıcı admin değilse, giriş sayfasına yönlendir

    if (Applist.currentuser == null || Applist.currentuser!.role != "Admin") {
      return RouteSettings(name: '/login'); // Login sayfasına yönlendirme
    }

    return null;
  }
}
