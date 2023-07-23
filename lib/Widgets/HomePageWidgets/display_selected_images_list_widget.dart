import 'dart:io';

import 'package:ffmpeg_slideshow/Bloc/GalleryBloc/gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplaySelectedImagesListWidget extends StatelessWidget {
  const DisplaySelectedImagesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double borderRadiusValue = 32;
    return BlocBuilder<GalleryBloc, PhotoSelectedState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                state.photoPathList.isEmpty ? 3 : state.photoPathList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadiusValue),
                        border: Border.all()),
                    child: state.photoPathList.isEmpty
                        ? notSelectedImageWidget()
                        : selectedImageWidget(borderRadiusValue, index, state)),
              );
            },
          ),
        );
      },
    );
  }

  Widget notSelectedImageWidget() {
    return const Icon(Icons.image, size: 100);
  }

  Widget selectedImageWidget(
      double borderRadiusValue, int index, PhotoSelectedState state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusValue),
      child: Image.file(
        File(state.photoPathList[index].path),
        fit: BoxFit.cover,
      ),
    );
  }
}
