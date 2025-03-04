import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/applist.dart';
import 'package:gameshowcase/app/functions/functions.dart';
import 'package:gameshowcase/app/models/user.dart';
import 'package:get/get.dart';
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;

class AppbarWidget {
  static appbar1() {
    final user = Applist.storage.read('user');
    if (user != null) {
      Applist.currentuser = User.fromJson(user);
    }

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          },
          icon: const Icon(
            Icons.dark_mode,
          ),
        ),
        toolbarHeight: 104.0,
        title: InkWell(
          onTap: () {
            Functions.golink('home');
          },
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            height: 50,
          ),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(Icons.blur_circular),
                SizedBox(width: 5),
                Text('turkce'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: VerticalDivider(),
          ),
          Applist.currentuser == null
              ? ElevatedButton(
                  onPressed: () {
                    // Get.toNamed("login");
                    Functions.golink('login');
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 5),
                          Text('oturum ac'),
                        ],
                      )
                    ],
                  ),
                )
              : PopupMenuButton<String>(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          foregroundImage: CachedNetworkImageProvider(
                            Applist.currentuser!.avatar,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(Applist.currentuser!.username),
                      ],
                    ),
                  ),
                  onSelected: (value) {
                    // Seçilen değeri işleme
                    if (kDebugMode) {
                      print("Selected: $value");
                    }

                    if (value == 'logout') {
                      html.window.location.reload();
                      Applist.storage.remove('user');
                      Applist.currentuser = null;
                      Get.offAllNamed('home');
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "profile",
                        child: Text("Profile"),
                      ),
                      const PopupMenuItem(
                        value: "settings",
                        child: Text("Settings"),
                      ),
                      const PopupMenuItem(
                        value: "logout",
                        child: Text("Logout"),
                      ),
                    ];
                  },
                ),
          InkWell(
            onTap: () {
              Functions.golink('gamebutton');
            },
            child: Container(
              width: 150,
              color: Colors.amber,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'ŞİMDİ OYNA',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black,
                            offset: Offset(4, 4),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
