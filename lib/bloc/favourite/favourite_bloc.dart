import 'package:bloc/bloc.dart';
import 'package:flutter_widgets/bloc/favourite/favourite_event.dart';
import 'package:flutter_widgets/bloc/favourite/favourite_state.dart';
import 'package:flutter_widgets/model/favourite_item_model.dart';
import 'package:flutter_widgets/repository/favourite_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteItemList = [];

  FavouriteRepository favouriteRepository;
  FavouriteBloc(this.favouriteRepository) : super(FavouriteState()) {
    on<FetchFavouriteEvent>(_fetchList);
    on<FavouriteItem>(_favoriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteEvent>(_deleteItem);
  }

  void _fetchList(FavouriteEvent event, Emitter<FavouriteState> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success,
      ),
    );
  }

  void _favoriteItem(FavouriteItem event, Emitter<FavouriteState> emit) async {
    final index = favouriteList.indexWhere((ele) => ele.id == event.item.id);
    if (event.item.isFavourite) {
      if (tempFavouriteItemList.contains(favouriteList[index])) {
        tempFavouriteItemList.remove(favouriteList[index]);
        tempFavouriteItemList.add(event.item);
      }
    } else {
      if (tempFavouriteItemList.contains(favouriteList[index])) {
        tempFavouriteItemList.remove(favouriteList[index]);
        tempFavouriteItemList.add(event.item);
      }
    }
    favouriteList[index] = event.item;
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempFavouriteItemList: List.from(tempFavouriteItemList),
      ),
    );
  }

  void _selectItem(SelectItem event, Emitter<FavouriteState> emit) async {
    tempFavouriteItemList.add(event.item);
    emit(
      state.copyWith(tempFavouriteItemList: List.from(tempFavouriteItemList)),
    );
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavouriteState> emit) async {
    tempFavouriteItemList.remove(event.item);
    emit(
      state.copyWith(tempFavouriteItemList: List.from(tempFavouriteItemList)),
    );
  }

  void _deleteItem(DeleteEvent event, Emitter<FavouriteState> emit) async {
    for (int i = 0; i < tempFavouriteItemList.length; i++) {
      favouriteList.remove(tempFavouriteItemList[i]);
    }
    tempFavouriteItemList.clear();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempFavouriteItemList: List.from(tempFavouriteItemList),
      ),
    );
  }
}
