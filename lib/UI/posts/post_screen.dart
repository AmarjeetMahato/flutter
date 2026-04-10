import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/bloc/post/post_bloc.dart';
import 'package:flutter_widgets/bloc/post/post_event.dart';
import 'package:flutter_widgets/bloc/post/post_state.dart';
import 'package:flutter_widgets/utils/enums.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("POST")),
      body: SafeArea(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            switch (state.postStatus) {
              case PostStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case PostStatus.failure:
                return Text(state.message.toString());
              case PostStatus.success:
                return ListView.builder(
                  itemCount: state.postList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = state.postList![index];
                    return Card(
                      elevation: 2, // Controls the shadow depth
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ), // Spacing between boxes
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Rounded corners
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ), // Optional border
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          16.0,
                        ), // Spacing inside the box
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title (Email)
                            Text(
                              item.email.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ), // Gap between title and subtitle
                            // Divider (Optional)
                            Divider(color: Colors.grey.shade200),
                            const SizedBox(height: 8),

                            // Subtitle (Body)
                            Text(
                              item.body.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                height: 1.4, // Improves readability
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              default:
                // This handles 'null' or any initial state before loading starts
                return const Center(child: Text("Initializing..."));
            }
          },
        ),
      ),
    );
  }
}
