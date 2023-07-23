import 'package:ffmpeg_slideshow/Bloc/GalleryBloc/gallery_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InProgressWidget extends StatelessWidget {
  const InProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GalleryBloc, PhotoSelectedState>(
        builder: (context, state) {
      return Visibility(
        visible: context.read<GalleryBloc>().state.isProgress,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.black54,
            ),
            const Center(
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    color: Colors.yellow,
                  )),
            ),
          ],
        ),
      );
    });
  }
}
