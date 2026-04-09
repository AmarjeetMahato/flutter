import 'package:equatable/equatable.dart';

abstract class ImagepickerEvent extends Equatable {
  const ImagepickerEvent();

  @override
  List<Object> get props => [];
}

class CameraCapture extends ImagepickerEvent {}

class Gallerypicker extends ImagepickerEvent {}

class ResetPicker extends ImagepickerEvent {}
