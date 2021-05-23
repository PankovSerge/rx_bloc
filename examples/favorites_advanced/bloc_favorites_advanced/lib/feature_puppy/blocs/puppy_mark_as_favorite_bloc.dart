import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/base/common_blocs/coordinator_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:favorites_advanced_base/models.dart';
import 'package:favorites_advanced_base/repositories.dart';

part 'puppy_mark_as_favorite_event.dart';

part 'puppy_mark_as_favorite_state.dart';

class PuppyMarkAsFavoriteBloc
    extends Bloc<PuppyManageEvent, PuppyMarkAsFavoriteState> {
  PuppyMarkAsFavoriteBloc({
    required PuppiesRepository puppiesRepository,
    required CoordinatorBloc coordinatorBloc,
    // Puppy? puppy,
  })   :
        // _puppy = puppy,
        _puppiesRepository = puppiesRepository,
        _coordinatorBloc = coordinatorBloc,
        super(const PuppyMarkAsFavoriteState());

  // final Puppy? _puppy;
  // final PuppyValidator _puppyValidator;
  final PuppiesRepository _puppiesRepository;
  final CoordinatorBloc _coordinatorBloc;

  @override
  Stream<PuppyMarkAsFavoriteState> mapEventToState(
    PuppyManageEvent event,
  ) async* {
    if (event is PuppyMarkAsFavoriteEvent) {
      yield* _mapToMarkAsFavorite(event);
    }
  }

  Stream<PuppyMarkAsFavoriteState> _mapToMarkAsFavorite(
      PuppyMarkAsFavoriteEvent event) async* {
    final puppy = event.puppy;
    final isFavorite = event.isFavorite;
    try {
      ///Send event to search list to change the icon immediately
      _coordinatorBloc.add(
          CoordinatorPuppyUpdatedEvent(puppy.copyWith(isFavorite: isFavorite)));

      await _puppiesRepository.favoritePuppy(
        puppy,
        isFavorite: isFavorite,
      );

      _coordinatorBloc.add(CoordinatorFavoritePuppyUpdatedEvent(
        favoritePuppy: puppy.copyWith(isFavorite: isFavorite),
        updateException: '',
      ));
    } on Exception catch (e) {
      final revertFavoritePuppy = puppy.copyWith(isFavorite: !isFavorite);
      _coordinatorBloc.add(CoordinatorPuppyUpdatedEvent(revertFavoritePuppy));

      yield state.copyWith(error: e.toString());
      _coordinatorBloc.add(CoordinatorFavoritePuppyUpdatedEvent(
          favoritePuppy: puppy, updateException: e.toString()));
    }
  }
}
