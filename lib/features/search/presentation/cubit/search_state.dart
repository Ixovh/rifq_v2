part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchIdle extends SearchState {
  final List<String> recentSearches;

  const SearchIdle({required this.recentSearches});

  @override
  List<Object?> get props => [recentSearches];
}

final class SearchLoading extends SearchState {}

final class SearchHotelResults extends SearchState {
  final List<HotelListItemEntity> hotels;

  const SearchHotelResults({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

final class SearchSitterResults extends SearchState {
  final List<HomeBoardingListItemEntity> sitters;

  const SearchSitterResults({required this.sitters});

  @override
  List<Object?> get props => [sitters];
}

final class SearchEmpty extends SearchState {
  const SearchEmpty();
}

final class SearchError extends SearchState {
  final String msg;

  const SearchError({required this.msg});

  @override
  List<Object?> get props => [msg];
}
