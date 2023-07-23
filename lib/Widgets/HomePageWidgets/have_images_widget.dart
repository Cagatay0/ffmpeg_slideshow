import 'package:ffmpeg_slideshow/Widgets/HomePageWidgets/convert_to_video_button_widget.dart';
import 'package:ffmpeg_slideshow/Widgets/HomePageWidgets/display_selected_images_list_widget.dart';
import 'package:ffmpeg_slideshow/Widgets/HomePageWidgets/select_image_widget.dart';
import 'package:ffmpeg_slideshow/Widgets/in_progress_widget.dart';
import 'package:flutter/material.dart';

class HaveImagesWidget extends StatelessWidget {
  const HaveImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 20),
            DisplaySelectedImagesListWidget(),
            SizedBox(height: 20),
            SelectImageWidget(),
            SizedBox(height: 20),
            ConvertToVideoButtonWidget(),
          ],
        ),
        InProgressWidget()
      ],
    );
  }
}
