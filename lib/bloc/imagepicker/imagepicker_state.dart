import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagepickerState extends Equatable {
  final XFile? file;
  const ImagepickerState({required this.file});

  ImagepickerState copyWith({XFile? file}) {
    return ImagepickerState(file: file ?? this.file);
  }

  @override
  List<Object?> get props => [file];
}
