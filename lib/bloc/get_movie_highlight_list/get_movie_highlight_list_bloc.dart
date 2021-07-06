import 'package:alia_movie/bloc/get_movie_highlight_list/get_movie_highlight_list_event.dart';
import 'package:alia_movie/bloc/get_movie_highlight_list/get_movie_highlight_list_state.dart';
import 'package:alia_movie/domain/movie_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMovieHighlightListBloc
    extends Bloc<GetMovieHighlightListEvent, GetMovieHighlightListState> {
  GetMovieHighlightListBloc() : super(GetMovieHighlightListState());
  MovieDomain _movieDomain = MovieDomain();

  static const QUERY = 'Money';
  var _page = 1;

  @override
  Stream<GetMovieHighlightListState> mapEventToState(
      GetMovieHighlightListEvent event) async* {
    if (event is GetMovieHighlightListEvent && !_hasReachedMax(state)) {
      yield* _mapMovieHighlightToState();
    }
  }

  Stream<GetMovieHighlightListState> _mapMovieHighlightToState() async* {
    try {
      if (state is GetMovieHighlightListState) {
        final data = await _movieDomain.getMovies(QUERY, _page);
        yield GetMovieHighlightListUpdateListState(
            movies: data.results, hasReachedMax: false);
      }

      if (state is GetMovieHighlightListUpdateListState) {
        final currentState = state as GetMovieHighlightListUpdateListState;
        final nextPage = await _movieDomain.getMovies(QUERY, _page += 1);
        yield nextPage.results.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : GetMovieHighlightListUpdateListState(
                movies: currentState.movies + nextPage.results,
                hasReachedMax: false);
      }
    } catch (e) {
      yield GetMovieHighlightListErrorState(message: e.toString());
    }
  }

  bool _hasReachedMax(GetMovieHighlightListState state) =>
      state is GetMovieHighlightListUpdateListState && state.hasReachedMax;
}
