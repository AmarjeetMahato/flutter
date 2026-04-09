import 'package:flutter_widgets/model/favourite_item_model.dart';

class FavouriteRepository {
  Future<List<FavouriteItemModel>> fetchItem() async {
    await Future.delayed(Duration(seconds: 2));
    return List.of(_generateList(10));
  }

  List<FavouriteItemModel> _generateList(int length) {
    return List.generate(
      length,
      (index) => FavouriteItemModel(id: index.toString(), value: 'Item $index'),
    );
  }
}
