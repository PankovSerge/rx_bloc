import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';

import 'package:favorites_advanced_base/models.dart';

import '../../../base/models/app_state.dart';
import '../../../feature_puppy/details/redux/actions.dart';
import '../../../feature_puppy/search/redux/actions.dart';

class FavoritesViewModel extends Equatable {
  const FavoritesViewModel({
    required this.puppies,
    required this.onToggleFavorite,
    required this.onDetailsPuppy,
  });

  factory FavoritesViewModel.from(Store<AppState> store) {
    void _onToggleFavorite(Puppy puppy, bool isFavorite) {
      store.dispatch(PuppyToggleFavoriteAction(
        puppy: puppy,
        isFavorite: isFavorite,
      ));
    }

    void _onDetailsPuppy(Puppy puppy) {
      store.dispatch(ModifyDetailsPuppy(puppy: puppy));
    }

    return FavoritesViewModel(
      puppies: store.state.favoriteListState.puppies,
      onToggleFavorite: _onToggleFavorite,
      onDetailsPuppy: _onDetailsPuppy,
    );
  }

  final List<Puppy> puppies;
  final Function(Puppy, bool) onToggleFavorite;
  final Function onDetailsPuppy;

  @override
  List<Object> get props => [
        puppies,
        onToggleFavorite,
        onDetailsPuppy,
      ];
}
