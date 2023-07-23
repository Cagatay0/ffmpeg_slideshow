import 'package:ffmpeg_slideshow/Bloc/GalleryBloc/gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertToVideoButtonWidget extends StatelessWidget {
  const ConvertToVideoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GalleryBloc>().add(ConvertToVideoEvent()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Text(
          'Convert to Video',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
