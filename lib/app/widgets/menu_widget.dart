import 'package:flutter/material.dart';
import 'package:gameshowcase/app/functions/functions.dart';

class MenuWidget {
  static Widget menu() {
    return Container(
      color: Colors.black38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavButton('OYUN', 'gamebutton'),
          _buildNavButton('HABERLER', 'news'),
          _buildNavButton('ETKİNLİKLER', 'events'),
          _buildNavButton('DESTEK', 'help'),
          _buildNavButton('ADMIN PANEL', 'dashboard'),
        ],
      ),
    );
  }

  static _buildNavButton(String text, String route) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          Functions.golink(route);
        },
        child: Text(text),
      ),
    );
  }
}
