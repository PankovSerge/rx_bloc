import 'package:favorites_advanced_base/models.dart';
import 'package:favorites_advanced_base/resources.dart';
import 'package:favorites_advanced_base/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:booking_app/base/flow_builders/hotel_flow.dart';

import '../../list/ui_components/hotel_animated_list_view.dart';
import '../blocs/favorite_hotels_bloc.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        key: const ValueKey(Keys.hotelFavoritesPage),
        children: [
          Expanded(
            child: HotelAnimatedListView(
              hotelList: RxBlocProvider.of<FavoriteHotelsBlocType>(context)
                  .states
                  .favoriteHotels
                  .whereSuccess(),
              onHotelPressed: (hotel) =>
                  Navigator.of(context).push(HotelFlow.route(hotel: hotel)),
            ),
          ),
          RxResultBuilder<FavoriteHotelsBlocType, List<Hotel>>(
            state: (bloc) => bloc.states.favoriteHotels,
            buildLoading: (ctx, bloc) => LoadingWidget(),
            buildError: (ctx, error, bloc) => ErrorRetryWidget(
              onReloadTap: () => RxBlocProvider.of<FavoriteHotelsBlocType>(ctx)
                  .events
                  .reloadFavoriteHotels(silently: false),
            ),
            buildSuccess: (ctx, snapshot, bloc) => Container(),
          )
        ],
      );
}
