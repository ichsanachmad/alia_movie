import 'package:alia_movie/bloc/bloc.dart';
import 'package:alia_movie/data/local/local_repository.dart';
import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:alia_movie/utils/assets/image_utils.dart';
import 'package:alia_movie/utils/date/custom_date.dart';
import 'package:alia_movie/widgets/snackbar.dart';
import 'package:alia_movie/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class DetailScreen extends StatelessWidget {
  static const ROUTE = '/detail';
  final Movie movie;

  DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddMovieScheduleBloc>(
            create: (context) => AddMovieScheduleBloc()),
        BlocProvider<UpdateMovieScheduleBloc>(
            create: (context) => UpdateMovieScheduleBloc()),
        BlocProvider<DeleteMovieScheduleBloc>(
            create: (context) => DeleteMovieScheduleBloc()),
        BlocProvider<GetMovieScheduleDetailBloc>(
            create: (context) => GetMovieScheduleDetailBloc()),
      ],
      child: _DetailContainer(movie: movie),
    );
  }
}

class _DetailContainer extends StatefulWidget {
  final Movie movie;

  _DetailContainer({required this.movie});

  @override
  _DetailContainerState createState() => _DetailContainerState();
}

class _DetailContainerState extends State<_DetailContainer> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _scheduleDateController = TextEditingController();
  TextEditingController _scheduleNoteController = TextEditingController();
  var _isAdded = false;

  @override
  void initState() {
    context
        .read<GetMovieScheduleDetailBloc>()
        .add(GetMovieScheduleDetailEvent(id: widget.movie.id));
    super.initState();
  }

  @override
  void dispose() {
    _scheduleDateController.dispose();
    _scheduleNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetMovieScheduleDetailBloc,
        GetMovieScheduleDetailState>(
      listener: (BuildContext context, state) {
        if (state is GetMovieScheduleDetailSuccessState) {
          if (state.movies.length > 0) {
            final movie = state.movies[0];
            setState(() {
              _isAdded = true;
              _scheduleDateController.text = movie.date;
              _scheduleNoteController.text = movie.note;
            });
          }
        }
      },
      child: BlocListener<AddMovieScheduleBloc, AddMovieScheduleState>(
        listener: (BuildContext context, state) {
          if (state is AddMovieScheduleSuccessState) {
            showSnackBar(context, message: state.message);
            setState(() {
              _isAdded = true;
            });
          }
          if (state is AddMovieScheduleErrorState) {
            showSnackBar(context, message: state.message);
          }
        },
        child: BlocListener<DeleteMovieScheduleBloc, DeleteMovieScheduleState>(
          listener: (BuildContext context, state) {
            if (state is DeleteMovieScheduleSuccessState) {
              showSnackBar(context, message: state.message);
              setState(() {
                _isAdded = false;
                _scheduleDateController.clear();
                _scheduleNoteController.clear();
              });
            }
            if (state is DeleteMovieScheduleErrorState) {
              showSnackBar(context, message: state.message);
            }
          },
          child:
              BlocListener<UpdateMovieScheduleBloc, UpdateMovieScheduleState>(
            listener: (BuildContext context, state) {
              if (state is UpdateMovieScheduleSuccessState) {
                showSnackBar(context, message: state.message);
              }

              if (state is UpdateMovieScheduleErrorState) {
                showSnackBar(context, message: state.message);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: ListView(
                children: [
                  Stack(
                    children: [
                      _DetailHeader(url: widget.movie.imagePath),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              widget.movie.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              'Release: ${CustomDate.stringDateFromString(widget.movie.releaseDate)}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              widget.movie.overview ?? '',
                              style: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SafeArea(
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 32),
                    child: Text(
                      'Schedule to Watch Movie',
                      style: TextStyle(
                        fontFamily: FontUtils.POPPINS,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Date for Schedule',
                              style: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _scheduleDateController,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1999),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                DateFormat formatter = DateFormat('yyyy-MM-dd');
                                _scheduleDateController.text =
                                    formatter.format(pickedDate);
                              }
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'yyyy-MM-dd',
                              hintStyle: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: FontUtils.POPPINS,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill schedule date field';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                          ),
                          SizedBox(height: 16),
                          Container(
                            child: Text(
                              'Note for Schedule',
                              style: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _scheduleNoteController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'ex: Watch with my Family',
                              hintStyle: TextStyle(
                                fontFamily: FontUtils.POPPINS,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: FontUtils.POPPINS,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill schedule note field';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: IconedCircularButton(
                      icon: Icon(Icons.save),
                      label: _isAdded ? 'Save Schedule' : 'Add Schedule',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!_isAdded) {
                            context.read<AddMovieScheduleBloc>().add(
                                  AddMovieScheduleEvent(
                                    movieScheduleData: MovieScheduleCompanion(
                                      id: moor.Value(widget.movie.id),
                                      title: moor.Value(widget.movie.title),
                                      imagePath: moor.Value(
                                          widget.movie.imagePath ??
                                              ImageUtils.MOVIE_TEMP_URL),
                                      releaseDate: moor.Value(
                                          widget.movie.releaseDate ?? ''),
                                      overview: moor.Value(
                                          widget.movie.overview ?? ''),
                                      date: moor.Value(_scheduleDateController
                                          .text
                                          .toString()),
                                      note: moor.Value(_scheduleNoteController
                                          .text
                                          .toString()),
                                    ),
                                  ),
                                );
                          } else {
                            context.read<UpdateMovieScheduleBloc>().add(
                                  UpdateMovieScheduleEvent(
                                    movieScheduleData: MovieScheduleCompanion(
                                      id: moor.Value(widget.movie.id),
                                      title: moor.Value(widget.movie.title),
                                      imagePath: moor.Value(
                                          widget.movie.imagePath ??
                                              ImageUtils.MOVIE_TEMP_URL),
                                      releaseDate: moor.Value(
                                          widget.movie.releaseDate ?? ''),
                                      overview: moor.Value(
                                          widget.movie.overview ?? ''),
                                      date: moor.Value(_scheduleDateController
                                          .text
                                          .toString()),
                                      note: moor.Value(_scheduleNoteController
                                          .text
                                          .toString()),
                                    ),
                                  ),
                                );
                          }
                        }
                      },
                    ),
                  ),
                  if (_isAdded)
                    Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 4, bottom: 8),
                      child: IconedCircularButton(
                        icon: Icon(Icons.delete),
                        label: 'Delete Schedule',
                        color: Colors.red[500],
                        onPressed: () {
                          context.read<DeleteMovieScheduleBloc>().add(
                                DeleteMovieScheduleEvent(
                                  movieScheduleData: MovieScheduleCompanion(
                                    id: moor.Value(widget.movie.id),
                                    title: moor.Value(widget.movie.title),
                                    imagePath: moor.Value(
                                        widget.movie.imagePath ??
                                            ImageUtils.MOVIE_TEMP_URL),
                                    releaseDate: moor.Value(
                                        widget.movie.releaseDate ?? ''),
                                    overview:
                                        moor.Value(widget.movie.overview ?? ''),
                                    date: moor.Value(_scheduleDateController
                                        .text
                                        .toString()),
                                    note: moor.Value(_scheduleNoteController
                                        .text
                                        .toString()),
                                  ),
                                ),
                              );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final String? url;

  _DetailHeader({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width,
      child: ShaderMask(
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
                ImageUtils.IMAGE_500 + (url ?? ImageUtils.MOVIE_TEMP_URL),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
