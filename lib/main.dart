import 'package:flutter/material.dart';
import 'package:flutter_widgets/UI/posts/post_screen.dart';
import 'package:flutter_widgets/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/bloc/favourite/favourite_bloc.dart';
import 'package:flutter_widgets/bloc/imagepicker/imagepicker_bloc.dart';
import 'package:flutter_widgets/bloc/post/post_bloc.dart';
import 'package:flutter_widgets/bloc/switch/switch_bloc.dart';
import 'package:flutter_widgets/bloc/todo/todo_bloc.dart';
import 'package:flutter_widgets/repository/favourite_repository.dart';
import 'package:flutter_widgets/utils/image_picker_utils.dart'; // 1. Import added

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ImagepickerBloc(ImagePickerUtils())),
        BlocProvider(create: (_) => TodoBloc()),
        BlocProvider(create: (_) => FavouriteBloc(FavouriteRepository())),
        BlocProvider(create: (_) => PostBloc()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // 2. Fixed syntax: ColorScheme.fromSeed
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PostScreen(),
      ),
    );
  }
}
