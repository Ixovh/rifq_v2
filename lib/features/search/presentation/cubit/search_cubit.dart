import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/use_cases/home_boarding_use_case.dart';
import 'package:rifq_v2/features/hotel/domain/entities/hotel_entity.dart';
import 'package:rifq_v2/features/hotel/domain/use_cases/hotel_use_case.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/recent_searches_store.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final HotelUseCase _hotelUseCase;
  final HomeBoardingUseCase _homeBoardingUseCase;

  SearchCubit(this._hotelUseCase, this._homeBoardingUseCase)
    : super(SearchIdle(recentSearches: RecentSearchesStore.read()));

  static const _genericErrorMessage =
      'Something went wrong searching. Please try again.';

  Timer? _debounce;
  BoardingTab _tab = BoardingTab.hotels;
  String _lastQuery = '';

  void setTab(BoardingTab tab) => _tab = tab;

  void onQueryChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(SearchIdle(recentSearches: RecentSearchesStore.read()));
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 400),
      () => _search(query),
    );
  }

  Future<void> retryLastSearch() => _search(_lastQuery);

  Future<void> runRecentSearch(String query) {
    _debounce?.cancel();
    return _search(query);
  }

  Future<void> _search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    _lastQuery = trimmed;
    emit(SearchLoading());

    if (_tab == BoardingTab.hotels) {
      (await _hotelUseCase.getHotels(searchQuery: trimmed)).when(
        (hotels) {
          RecentSearchesStore.add(trimmed);
          emit(
            hotels.isEmpty
                ? const SearchEmpty()
                : SearchHotelResults(hotels: hotels),
          );
        },
        (error) {
          debugPrint(
            'SearchCubit._search (hotels) failed: '
            '${CatchErrorMessage(error: error).getWriteMessage()}',
          );
          emit(const SearchError(msg: _genericErrorMessage));
        },
      );
    } else {
      (await _homeBoardingUseCase.getSitters(searchQuery: trimmed)).when(
        (sitters) {
          RecentSearchesStore.add(trimmed);
          emit(
            sitters.isEmpty
                ? const SearchEmpty()
                : SearchSitterResults(sitters: sitters),
          );
        },
        (error) {
          debugPrint(
            'SearchCubit._search (sitters) failed: '
            '${CatchErrorMessage(error: error).getWriteMessage()}',
          );
          emit(const SearchError(msg: _genericErrorMessage));
        },
      );
    }
  }

  void removeRecentSearch(String query) {
    RecentSearchesStore.remove(query);
    emit(SearchIdle(recentSearches: RecentSearchesStore.read()));
  }

  void clearRecentSearches() {
    RecentSearchesStore.clear();
    emit(const SearchIdle(recentSearches: []));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
