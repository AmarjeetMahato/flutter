import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/bloc/imagepicker/imagepicker_bloc.dart';
import 'package:flutter_widgets/bloc/imagepicker/imagepicker_event.dart';
import 'package:flutter_widgets/bloc/imagepicker/imagepicker_state.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker BLoC")),
      // Wrap the BlocBuilder with Center
      body: Center(
        child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
          builder: (context, state) {
            if (state.file == null) {
              return Row(
                // Use a Row to show both options
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Camera Button
                  _buildPickerIcon(
                    context,
                    icon: Icons.camera_alt,
                    onTap: () =>
                        context.read<ImagepickerBloc>().add(CameraCapture()),
                  ),
                  const SizedBox(width: 40),
                  // Gallery Button
                  _buildPickerIcon(
                    context,
                    icon: Icons.photo_library,
                    onTap: () => context.read<ImagepickerBloc>().add(
                      Gallerypicker(),
                    ), // New Event
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      // The Selected Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(state.file!.path),
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // The "Back to Options" Button
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            // This event must set state.file to null
                            context.read<ImagepickerBloc>().add(ResetPicker());
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Tap 'X' to pick a different source",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// Helper method to keep code clean
Widget _buildPickerIcon(
  BuildContext context, {
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: CircleAvatar(radius: 40, child: Icon(icon)),
  );
}
