import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:favorites_advanced_base/resources.dart';
import 'package:favorites_advanced_base/ui_components.dart';

import '../../../base/models/app_state.dart';
import 'favorites_view_model.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: StoreConnector<AppState, FavoritesViewModel>(
          key: const Key(Keys.puppyFavoritesPage),
          //onInit: (store) {},
          converter: (store) => FavoritesViewModel.from(store),
          builder: (ctx, viewModel) => AnimatedList(
            initialItemCount: viewModel.puppies.length,
            itemBuilder: (ctx, index, animation) {
              final item = viewModel.puppies[index];
              return PuppyCard(
                key: Key('${Keys.puppyCardNamePrefix}${item.id}'),
                puppy: item,
                onCardPressed: (puppy) {},
                onFavorite: (puppy, isFavorite) =>
                    viewModel.onToggleFavorite(puppy, isFavorite),
              );
            },
          ),
        ),
      );
}
