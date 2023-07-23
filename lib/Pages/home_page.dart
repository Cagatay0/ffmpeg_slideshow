import 'package:ffmpeg_slideshow/Bloc/GalleryBloc/gallery_state.dart';
import 'package:ffmpeg_slideshow/Widgets/HomePageWidgets/have_images_widget.dart';
import 'package:ffmpeg_slideshow/Widgets/HomePageWidgets/not_have_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Just testing Android Devices.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FFmpeg Slideshow'),
      ),
      body: mainWidget(),
    );
  }

  Widget mainWidget() {
    return BlocBuilder<GalleryBloc, PhotoSelectedState>(
        builder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.isConvertVideo) {
          showSnackBar(context, 'Video saved your gallery');
        }
      });

      return context.read<GalleryBloc>().state.photoPathList.isEmpty
          ? const NotHaveImagesWidget()
          : const HaveImagesWidget();
    });
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
