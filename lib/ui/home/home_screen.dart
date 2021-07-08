import 'package:alia_movie/bloc/bloc.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/data/model/model.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMovieHighlightListBloc>(
            create: (context) => GetMovieHighlightListBloc()),
        BlocProvider<GetMovieHeaderBloc>(
            create: (context) => GetMovieHeaderBloc()),
        BlocProvider<GetMovieScheduleStreamBloc>(
            create: (context) => GetMovieScheduleStreamBloc()),
      ],
      child: _HomeContainer(),
    );
  }
}

class _HomeContainer extends StatefulWidget {
  @override
  __HomeContainerState createState() => __HomeContainerState();
}

class __HomeContainerState extends State<_HomeContainer> {
  final ScrollController _movieScrollController = ScrollController();

  void _onScroll() {
    double maxScroll = _movieScrollController.position.maxScrollExtent;
    double currentScroll = _movieScrollController.position.pixels;

    if (currentScroll == maxScroll) {
      context
          .read<GetMovieHighlightListBloc>()
          .add(GetMovieHighlightListEvent());
    }
  }

  @override
  void initState() {
    _movieScrollController.addListener(_onScroll);
    context.read<GetMovieHighlightListBloc>().add(GetMovieHighlightListEvent());
    context.read<GetMovieHeaderBloc>().add(GetMovieHeaderEvent());
    context
        .read<GetMovieScheduleStreamBloc>()
        .add(OnGetMovieScheduleStreamEvent());
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
          Container(
            margin: EdgeInsets.only(left: 16, top: 24),
            child: Text(
              'Your Movie Schedule',
              style: TextStyle(
                fontFamily: FontUtils.POPPINS,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          BlocBuilder<GetMovieScheduleStreamBloc, GetMovieScheduleStreamState>(
              builder: (context, state) {
            if (state is GetMovieScheduleStreamSuccessState) {
              final movies = state.movies;
              if (movies.length > 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6, bottom: 10),
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, position) {
                          bool isFirst = position == 0;
                          bool isLast = position == movies.length - 1;
                          MovieScheduleData movieScheduleData =
                              movies[position];
                          Movie movie = Movie(
                              id: movieScheduleData.id,
                              title: movieScheduleData.title,
                              releaseDate: movieScheduleData.releaseDate,
                              imagePath: movieScheduleData.imagePath,
                              overview: movieScheduleData.overview);
                          return MovieHomeListItem(
                            movie: movie,
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
                                arguments: movie,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Text(
                    'Please Put Some Schedule From Movie Detail!',
                    style: TextStyle(
                      fontFamily: FontUtils.POPPINS,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                );
              }
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
