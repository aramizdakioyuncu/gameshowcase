import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/applist.dart';
import 'package:gameshowcase/app/functions/functions.dart';
import 'package:gameshowcase/app/models/user.dart';
import 'package:get/get.dart';
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
        toolbarHeight: 104.0,
        title: InkWell(
          onTap: () {
            if (kDebugMode) {
              Functions.golink('/');

              return;
            }
            Functions.golink('https://server.aramizdakioyuncu.com/spooky');
          },
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            height: 80,
          ),
        ),
        centerTitle: true,
        actions: [
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
                  onSelected: (value) async {
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
            onTap: () async {
              // Functions.golink('gamebutton');
            },
            child: Container(
              width: 150,
              color: const Color.fromARGB(255, 27, 24, 234),
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
