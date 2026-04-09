import 'package:bloc/bloc.dart';
import 'package:flutter_widgets/bloc/imagepicker/imagepicker_event.dart';
import 'package:flutter_widgets/bloc/imagepicker/imagepicker_state.dart';
import 'package:flutter_widgets/utils/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagepickerBloc extends Bloc<ImagepickerEvent, ImagepickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagepickerBloc(this.imagePickerUtils)
    : super(const ImagepickerState(file: null)) {
    on<CameraCapture>(cameraCapture);
    on<Gallerypicker>(gallerypicker);
    on<ResetPicker>(resetPicker);
  }

  void resetPicker(ResetPicker event, Emitter<ImagepickerState> states) {
    emit(const ImagepickerState(file: null));
  }

  void cameraCapture(
    CameraCapture event,
    Emitter<ImagepickerState> states,
  ) async {
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }

  void gallerypicker(
    Gallerypicker event,
    Emitter<ImagepickerState> states,
  ) async {
    XFile? file = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }
}
