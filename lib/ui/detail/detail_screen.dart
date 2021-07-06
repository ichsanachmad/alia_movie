import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:alia_movie/utils/assets/image_utils.dart';
import 'package:alia_movie/utils/colors/color_hex.dart';
import 'package:alia_movie/utils/colors/color_utils.dart';
import 'package:alia_movie/widgets/widget.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const ROUTE = '/detail';
  final Movie? movie;

  DetailScreen({this.movie});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
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
                'Feedback',
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
                child: TextFormField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Give Feedback...',
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
                      return 'Fill feedback field';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: IconedCircularButton(
                icon: Icon(Icons.play_arrow),
                label: 'Send Feedback',
                onPressed: () {
                  if (_formKey.currentState!.validate())
                    showFeedbackBottomSheet(context,
                        feedback: _feedbackController.text.toString());
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

void showFeedbackBottomSheet(BuildContext context, {required String feedback}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: ColorHex(ColorUtils.GREY),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 8, top: 4),
                child: InkWell(
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, top: 20),
                  child: Text(
                    'Your Feedback',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontUtils.POPPINS,
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    feedback,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontUtils.POPPINS,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}
