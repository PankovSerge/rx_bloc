part of 'home_page.dart';

List<RxBlocProvider> _getProviders() => [
      RxBlocProvider<FavoriteHotelsBlocType>(
        create: (context) => FavoriteHotelsBloc(
          Provider.of(context, listen: false),
          Provider.of(context, listen: false),
        ),
      ),
      RxBlocProvider<HotelManageBlocType>(
        create: (context) => HotelManageBloc(
          Provider.of(context, listen: false),
          Provider.of(context, listen: false),
        ),
      ),
      RxBlocProvider<HotelsExtraDetailsBlocType>(
        create: (context) => HotelsExtraDetailsBloc(
          Provider.of(context, listen: false),
          Provider.of(context, listen: false),
        ),
      ),
      RxBlocProvider<NavigationBarBlocType>(
        create: (context) => NavigationBarBloc(),
      ),
    ];
