import 'package:equatable/equatable.dart';
import 'package:flutter_widgets/model/favourite_item_model.dart';

enum ListStatus { loading, success, failure }

class FavouriteState extends Equatable {
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> tempFavouriteItemList;

  final ListStatus listStatus;
  const FavouriteState({
    this.favouriteItemList = const [],
    this.listStatus = ListStatus.loading,
    this.tempFavouriteItemList = const [],
  });

  FavouriteState copyWith({
    List<FavouriteItemModel>? favouriteItemList,
    List<FavouriteItemModel>? tempFavouriteItemList,
    ListStatus? listStatus,
    T,
  }) {
    return FavouriteState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      tempFavouriteItemList:
          tempFavouriteItemList ?? this.tempFavouriteItemList,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object?> get props => [
    favouriteItemList,
    tempFavouriteItemList,
    listStatus,
  ];
}
