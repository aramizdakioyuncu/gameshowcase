import 'package:flutter/material.dart';
import 'package:gameshowcase/app/widgets/menu_widget.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:gameshowcase/app/functions/functions.dart';
import 'package:gameshowcase/app/modules/home/controllers/home_controller.dart';
import 'package:gameshowcase/app/widgets/appbar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      appBar: AppbarWidget.appbar1(),
      body: Stack(
        children: [
          Image.asset(
            'assets/wallpapers/login.gif',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.black.withOpacity(0.75), // karanlık efekti
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MenuWidget.menu(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                  ),
                ),

                // Altındaki açıklama yazısı
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Text(
                        '''
Uzayın derinliklerindeki bir arenada amansız bir savaş oyunu.
Hayaletlerin takımlar halinde birbiriyle savaştığı bir ortam.

Oynanış

"W", "A", "S", "D" --> Hareket etme
"Space"              --> Zıplama
"R"                      --> Karakter küçültme
"Mouse1"          --> Ateş etme
"LShift"              --> Koşma
''',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                blurRadius: 10,
                                color: const Color.fromARGB(255, 83, 83, 83),
                                offset: Offset(0, 0)),
                            Shadow(
                                blurRadius: 30,
                                color: const Color.fromARGB(255, 55, 44, 32),
                                offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ScaleButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScaleButton extends StatefulWidget {
  @override
  _ScaleButtonState createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.9; // Buton küçülüyor
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // Buton eski haline dönüyor
    });
    Functions.golink('maps');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Transform.scale(
          scale: _scale,
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/haritalar.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class YoutubePlayerWidget extends StatefulWidget {
  final String videoUrl;

  const YoutubePlayerWidget({super.key, required this.videoUrl});

  @override
  YoutubePlayerWidgetState createState() => YoutubePlayerWidgetState();
}

class YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl);

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? "",
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }
}
