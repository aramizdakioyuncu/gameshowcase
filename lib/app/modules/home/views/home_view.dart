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
            'wallpapers/login.jpg',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MenuWidget.menu(),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/siyah_arka_plan.jpg'),
                      ),
                    ),
                    height: 322,
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'GÜNCELLEME NOTLARI',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Functions.golink('gamebutton');
                                      },
                                      icon: Icon(Icons.next_plan_rounded),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 100),
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  'güncelleme notları 34.1',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: YoutubePlayerWidget(
                            videoUrl:
                                'https://youtu.be/OVmhjDnpM-w?si=dwbQHVcuR8QiLuNJ',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'HARİTALAR',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
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
                image: AssetImage('assets/images/siyah_arka_plan.jpg'),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'HARİTALARIMİZ',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/haritalar.png'),
                      ),
                    ),
                  ),
                ),
              ],
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
