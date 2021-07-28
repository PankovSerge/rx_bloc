import 'package:redux/redux.dart';

import 'package:favorites_advanced_base/models.dart';

import '../models/puppy_list_state.dart';
import 'actions.dart';

PuppyListState puppyListStateReducer(PuppyListState state, action) =>
    state.copyWith(
      isLoading: isLoadingReducer(state: state.isLoading, action: action),
      isError: isErrorReducer(state: state.isError, action: action),
      searchQuery: searchQueryReducer(state: state.searchQuery, action: action),
      puppies: puppyReducer(state.puppies, action),
    );

Reducer<List<Puppy>?> puppyReducer = combineReducers<List<Puppy>?>([
  TypedReducer<List<Puppy>?, PuppiesFetchSucceededAction>(
      puppiesFetchSucceededReducer),
  TypedReducer<List<Puppy>?, ExtraDetailsFetchSucceededAction>(
      extraDetailsFetchSucceededReducer),
  TypedReducer<List<Puppy>?, PuppyFavoriteSucceededAction>(
      puppyFavoriteSucceededReducer),
  TypedReducer<List<Puppy>?, UpdateSearchStatePuppyAction>(updatedPuppyReducer),
]);

List<Puppy>? puppiesFetchSucceededReducer(
        List<Puppy>? puppies, PuppiesFetchSucceededAction action) =>
    action.puppies;

List<Puppy>? extraDetailsFetchSucceededReducer(
        List<Puppy>? puppies, ExtraDetailsFetchSucceededAction action) =>
    puppies!.mergeWith(action.puppies);

List<Puppy>? puppyFavoriteSucceededReducer(
        List<Puppy>? puppies, PuppyFavoriteSucceededAction action) =>
    puppies!.mergeWith([action.puppy]);

List<Puppy> updatedPuppyReducer(
        List<Puppy>? puppies, UpdateSearchStatePuppyAction action) =>
    puppies!.map((puppy) {
      if (puppy.id == action.puppy.id) return action.puppy;
      return puppy;
    }).toList();

bool? isLoadingReducer({bool? state, action}) {
  if (action is PuppiesFetchLoadingAction) {
    return true;
  }
  if (action is PuppiesFetchSucceededAction ||
      action is PuppiesFetchFailedAction) {
    return false;
  }
  return state;
}

bool? isErrorReducer({bool? state, action}) {
  if (action is PuppiesFetchFailedAction) {
    return true;
  }
  if (action is PuppiesFetchSucceededAction) {
    return false;
  }
  return state;
}

String? searchQueryReducer({String? state, action}) {
  if (action is SaveSearchQueryAction) {
    return action.query;
  }
  return state;
}
