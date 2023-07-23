import 'package:ffmpeg_slideshow/Widgets/HomePageWidgets/select_image_widget.dart';
import 'package:flutter/material.dart';

class NotHaveImagesWidget extends StatelessWidget {
  const NotHaveImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: SelectImageWidget());
  }
}
