import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/bloc/favourite/favourite_bloc.dart';
import 'package:flutter_widgets/bloc/favourite/favourite_event.dart';
import 'package:flutter_widgets/bloc/favourite/favourite_state.dart';
import 'package:flutter_widgets/model/favourite_item_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FavouriteBloc>().add(FetchFavouriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favourite App", style: TextStyle(fontSize: 22)),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavouriteItemList.isNotEmpty ? true : false,
                child: IconButton(
                  onPressed: () {
                    context.read<FavouriteBloc>().add(DeleteEvent());
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ListStatus.failure:
                return Text("Somethings went wrong");
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: state.tempFavouriteItemList.contains(item)
                              ? true
                              : false,
                          onChanged: (value) {
                            if (value!) {
                              context.read<FavouriteBloc>().add(
                                SelectItem(item: item),
                              );
                            } else {
                              context.read<FavouriteBloc>().add(
                                UnSelectItem(item: item),
                              );
                            }
                          },
                        ),
                        title: Text(
                          item.value.toString(),
                          style: TextStyle(
                            // Toggle between lineThrough and none based on selection
                            decoration:
                                state.tempFavouriteItemList.contains(item)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            // Optional: Make the text slightly gray when crossed out
                            color: state.tempFavouriteItemList.contains(item)
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FavouriteItemModel itemModel = FavouriteItemModel(
                              id: item.id,
                              value: item.value,
                              isFavourite: item.isFavourite ? false : true,
                            );
                            context.read<FavouriteBloc>().add(
                              FavouriteItem(item: itemModel),
                            );
                          },
                          icon: Icon(
                            item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
