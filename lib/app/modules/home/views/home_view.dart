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
                                        icon: Icon(Icons.next_plan_rounded))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  'güncelleme notları 34.1',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: YoutubePlayerWidget(
                              videoUrl:
                                  'https://youtu.be/6QmWf4doGxA?si=F6oSh48pBjH4Rfw4'),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/siyah_arka_plan.jpg'),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('data'),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text('data'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/siyah_arka_plan.jpg'),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('data'),
                              ),
                              Expanded(flex: 1, child: Text('data')),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
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
