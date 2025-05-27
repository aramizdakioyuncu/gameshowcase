import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class StoryController extends GetxController {
  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  final List<String> imagePaths = [
    'assets/images/h1.png',
    'assets/images/h2.png',
    'assets/images/h3.png',
    'assets/images/h4.png',
    'assets/images/h5.png',
    'assets/images/h7.png',
    'assets/images/h8.png',
    'assets/images/h9.png',
    'assets/images/h10.png',
  ];

  final AudioPlayer _player = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    _startLoopedSound();
  }

  @override
  void onClose() {
    _player.stop();
    _player.dispose();
    super.onClose();
  }

  Future<void> _startLoopedSound() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('sounds/loading.wav'));
  }

  void nextImage() {
    if (currentIndex.value < imagePaths.length - 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousImage() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
