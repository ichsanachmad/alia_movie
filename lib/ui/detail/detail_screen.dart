import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:alia_movie/utils/assets/image_utils.dart';
import 'package:alia_movie/utils/date/custom_date.dart';
import 'package:alia_movie/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  static const ROUTE = '/detail';
  final Movie? movie;

  DetailScreen({this.movie});

  @override
  Widget build(BuildContext context) {
    return _DetailContainer(movie: movie);
  }
}

class _DetailContainer extends StatefulWidget {
  final Movie? movie;

  _DetailContainer({this.movie});

  @override
  _DetailContainerState createState() => _DetailContainerState();
}

class _DetailContainerState extends State<_DetailContainer> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _scheduleDateController = TextEditingController();
  TextEditingController _scheduleNoteController = TextEditingController();

  @override
  void dispose() {
    _scheduleDateController.dispose();
    _scheduleNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie != null)
      return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Stack(
              children: [
                _DetailHeader(url: widget.movie!.imagePath),
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
                        widget.movie!.title,
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
                        'Release: ${CustomDate.stringDateFromString(widget.movie!.releaseDate)}',
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
                        widget.movie!.overview ?? '',
                        style: TextStyle(
                          fontFamily: FontUtils.POPPINS,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
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
                  children: [
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
                        hintText: 'Schedule Date',
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
                    TextFormField(
                      controller: _scheduleNoteController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Note Schedule',
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
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: IconedCircularButton(
                icon: Icon(Icons.save),
                label: 'Save Schedule',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ),
          ],
        ),
      );
    else
      return Container();
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
        child: url != null
            ? Image.network(
                ImageUtils.IMAGE_500 + url!,
                fit: BoxFit.cover,
              )
            : Image.asset(ImageUtils.MOVIE_TEMP),
      ),
    );
  }
}
