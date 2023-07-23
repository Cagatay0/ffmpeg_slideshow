import 'package:ffmpeg_slideshow/Pages/home_page.dart';
import 'package:ffmpeg_slideshow/Bloc/GalleryBloc/gallery_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
