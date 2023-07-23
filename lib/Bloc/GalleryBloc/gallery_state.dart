import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

//Event
abstract class GalleryEvent {}

class SelectPhotoEvent extends GalleryEvent {}

class ConvertToVideoEvent extends GalleryEvent {}

//State
class PhotoSelectedState {
  List photoPathList;
  bool isProgress;
  bool isConvertVideo;
  PhotoSelectedState(this.photoPathList, this.isProgress, this.isConvertVideo);
}

//Bloc

class GalleryBloc extends Bloc<GalleryEvent, PhotoSelectedState> {
  GalleryBloc() : super(PhotoSelectedState([], false, false)) {
    on<SelectPhotoEvent>((event, emit) async {
      List<XFile> imageList = await checkUserPermission();
      state.photoPathList = imageList;
      emit(PhotoSelectedState(
          state.photoPathList, state.isProgress, state.isConvertVideo));
    });
    on<ConvertToVideoEvent>((event, emit) async {
      state.isProgress = true;
      emit(PhotoSelectedState(
          state.photoPathList, state.isProgress, state.isConvertVideo));

      await convertToVideo();

      emit(PhotoSelectedState(
          state.photoPathList, state.isProgress, state.isConvertVideo));
    });
  }

  Future<List<XFile>> checkUserPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      return await Permission.storage.request().then((value) {
        if (value.isGranted) {
          //open gallery
          return openUsersGallery();
        } else {
          return [];
        }
      });
    } else if (status.isGranted) {
      return openUsersGallery();
    } else {
      //GoToAppSettings
      openAppSettings();
      return [];
    }
  }

  Future<List<XFile>> openUsersGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> imageList = await picker.pickMultiImage();
    return imageList;
  }

  convertToVideo() async {
    state.isConvertVideo = false;
    String videoName = await createVideoId();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String fileName = '$videoName.mp4';
    String outputFilePath = "${documentDirectory.path}/$fileName";
    List commandGeneralList = ['-loop', '1', '-t', '5', '-r', '15', '-i'];
    List commandExecuteList = ['-loop', '1', '-t', '5', '-r', '15', '-i'];
    List commandOutputList = [
      '-filter_complex',
      'concat=n=${state.photoPathList.length}:v=1:a=0',
      '-y',
      outputFilePath
    ];
    int i = 0;
    for (XFile element in state.photoPathList) {
      if (i == 0) {
        commandExecuteList.add(element.path);
      } else {
        for (var element in commandGeneralList) {
          commandExecuteList.add(element);
        }
        commandExecuteList.add(element.path);
      }
      i += 1;
    }
    for (var element in commandOutputList) {
      commandExecuteList.add(element);
    }

    await FlutterFFmpeg()
        .executeWithArguments(commandExecuteList)
        .then((value) async {
      if (value == 0) {
        print('Video Created complete. Waiting save to phone gallery');
        await GallerySaver.saveVideo(outputFilePath);
        state.isProgress = false;
        state.isConvertVideo = true;

        print('Video save to phone gallery');
      } else {
        state.isProgress = false;
        state.isConvertVideo = false;

        print('Error!');
      }
    });
  }

  Future<String> createVideoId() async {
    final random = Random();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String returnId = '';
    for (int i = 0; i < 10; i++) {
      returnId += chars[random.nextInt(chars.length)];
    }
    return returnId;
  }
}
