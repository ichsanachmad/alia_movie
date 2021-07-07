import 'package:alia_movie/bloc/bloc.dart';
import 'package:alia_movie/ui/detail/detail_screen.dart';
import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:alia_movie/utils/assets/image_utils.dart';
import 'package:alia_movie/widgets/snackbar.dart';
import 'package:alia_movie/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE = '/home';

  final GetMovieHighlightListBloc getMovieHiglightBloc =
      GetMovieHighlightListBloc();
  final GetMovieHeaderBloc getMovieHeader = GetMovieHeaderBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMovieHighlightListBloc>(
            create: (context) => getMovieHiglightBloc),
        BlocProvider<GetMovieHeaderBloc>(create: (context) => getMovieHeader),
      ],
      child: _HomeContainer(
        getMovieHiglightBloc: getMovieHiglightBloc,
        getMovieHeader: getMovieHeader,
      ),
    );
  }
}

class _HomeContainer extends StatefulWidget {
  final GetMovieHighlightListBloc getMovieHiglightBloc;
  final GetMovieHeaderBloc getMovieHeader;

  _HomeContainer(
      {required this.getMovieHiglightBloc, required this.getMovieHeader});

  @override
  __HomeContainerState createState() => __HomeContainerState();
}

class __HomeContainerState extends State<_HomeContainer> {
  final ScrollController _movieScrollController = ScrollController();

  void _onScroll() {
    double maxScroll = _movieScrollController.position.maxScrollExtent;
    double currentScroll = _movieScrollController.position.pixels;

    if (currentScroll == maxScroll) {
      widget.getMovieHiglightBloc.add(GetMovieHighlightListEvent());
    }
  }

  @override
  void initState() {
    _movieScrollController.addListener(_onScroll);
    widget.getMovieHiglightBloc.add(GetMovieHighlightListEvent());
    widget.getMovieHeader.add(GetMovieHeaderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Stack(
            children: [
              _HomeHeader(),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.only(left: 8, top: 4),
                  child: Image.asset(
                    ImageUtils.LOGO,
                    width: 75,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    child: BlocBuilder<GetMovieHeaderBloc, GetMovieHeaderState>(
                        builder: (context, state) {
                      if (state is GetMovieHeaderSuccessState) {
                        return Text(
                          state.movie.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FontUtils.POPPINS,
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }
                      return Container();
                    }),
                  ),
                  BlocBuilder<GetMovieHeaderBloc, GetMovieHeaderState>(
                    builder: (context, state) {
                      if (state is GetMovieHeaderSuccessState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconTextColumn(
                              icon: Icon(Icons.play_arrow_outlined,
                                  color: Colors.white),
                              label: 'Play',
                              onPress: () {
                                showSnackBar(context,
                                    message: 'Please Subscribe to AliaMovie');
                              },
                            ),
                            IconTextColumn(
                              icon: Icon(Icons.info_outlined,
                                  color: Colors.white),
                              label: 'Detail',
                              onPress: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailScreen.ROUTE,
                                  arguments: state.movie,
                                );
                              },
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              )
            ],
          ),
          BlocBuilder<GetMovieHighlightListBloc, GetMovieHighlightListState>(
              builder: (context, state) {
            if (state is GetMovieHighlightListUpdateListState) {
              final movies = state.movies;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 24),
                    child: Text(
                      'Only On AliaMovie',
                      style: TextStyle(
                        fontFamily: FontUtils.POPPINS,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6, bottom: 10),
                    height: 130,
                    child: ListView.builder(
                      controller: _movieScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.hasReachedMax
                          ? movies.length
                          : movies.length + 1,
                      itemBuilder: (context, position) {
                        bool isFirst = position == 0;
                        bool isLast = position == movies.length - 1;

                        return position >= movies.length
                            ? Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [CircularProgressIndicator()]),
                              )
                            : MovieHomeListItem(
                                movie: movies[position],
                                isFirst: isFirst,
                                isLast: isLast,
                                onPlayCallback: () {
                                  Navigator.pop(context);
                                  showSnackBar(context,
                                      message: 'Please Subscribe to AliaMovie');
                                },
                                onDetailCallback: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailScreen.ROUTE,
                                    arguments: movies[position],
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          }),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<GetMovieHeaderBloc, GetMovieHeaderState>(
        builder: (context, state) {
          if (state is GetMovieHeaderSuccessState) {
            return ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.transparent,
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: Image.network(
                  ImageUtils.IMAGE_500 +
                      (state.movie.imagePath ?? ImageUtils.MOVIE_TEMP_URL),
                  fit: BoxFit.cover,
                ));
          }
          return Container();
        },
      ),
    );
  }
}
