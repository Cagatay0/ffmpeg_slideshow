import 'package:ffmpeg_slideshow/Bloc/GalleryBloc/gallery_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GalleryBloc>().add(SelectPhotoEvent());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(24),
        ),
        child: insideContainerTextWidget(context),
      ),
    );
  }

  Widget insideContainerTextWidget(BuildContext context) {
    return BlocBuilder<GalleryBloc, PhotoSelectedState>(
        builder: (context, state) {
      return Text(
        context.read<GalleryBloc>().state.photoPathList.isEmpty
            ? 'Select Images'
            : 'Change Images',
        style: const TextStyle(fontSize: 20, color: Colors.white),
      );
    });
  }
}
