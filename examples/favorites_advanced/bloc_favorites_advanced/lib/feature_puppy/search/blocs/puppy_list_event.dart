part of 'puppy_list_bloc.dart';

@immutable
abstract class PuppyListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReloadPuppiesEvent extends PuppyListEvent {
  ReloadPuppiesEvent();
}

class LoadPuppyListEvent extends PuppyListEvent {
  LoadPuppyListEvent();
}

class PuppyListFavoritePuppiesUpdatedEvent extends PuppyListEvent {
  PuppyListFavoritePuppiesUpdatedEvent({
    required this.favoritePuppies,
  });

  final List<Puppy> favoritePuppies;

  @override
  List<Object?> get props => [favoritePuppies];
}

class PuppyListFilterEvent extends PuppyListEvent {
  PuppyListFilterEvent({
    required this.query,
  });

  final String query;

  @override
  List<Object?> get props => [query];
}

class PuppyListFilterUpdatedQueryEvent extends PuppyListEvent {
  PuppyListFilterUpdatedQueryEvent({
    required this.query,
  });

  final String query;

  @override
  List<Object?> get props => [query];
}
