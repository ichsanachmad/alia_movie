import 'package:alia_movie/data/model/model.dart';
import 'package:alia_movie/utils/assets/font_utils.dart';
import 'package:alia_movie/utils/assets/image_utils.dart';
import 'package:alia_movie/utils/colors/color_hex.dart';
import 'package:alia_movie/utils/colors/color_utils.dart';
import 'package:alia_movie/widgets/widget.dart';
import 'package:flutter/material.dart';

class MovieHomeListItem extends StatelessWidget {
  final Movie movie;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onAddCallback;
  final VoidCallback onPlayCallback;
  final VoidCallback onDetailCallback;

  MovieHomeListItem({
    required this.movie,
    required this.isFirst,
    required this.isLast,
    required this.onAddCallback,
    required this.onPlayCallback,
    required this.onDetailCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: isFirst ? 16 : 8, right: isLast ? 16 : 0),
      width: 100,
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: movie.imagePath != null
              ? Image.network(
                  ImageUtils.IMAGE_185 + movie.imagePath!,
                  fit: BoxFit.cover,
                )
              : Image.asset(ImageUtils.MOVIE_TEMP),
        ),
        onTap: () {
          showInfoBottomSheet(
            context,
            movie: movie,
            onAddCallback: onAddCallback,
            onPlayCallback: onPlayCallback,
            onDetailCallback: onDetailCallback,
          );
        },
      ),
    );
  }
}

class MiniDetailBottomSheet extends StatelessWidget {
  final Movie movie;
  final VoidCallback onAddCallback;
  final VoidCallback onPlayCallback;
  final VoidCallback onDetailCallback;

  MiniDetailBottomSheet({
    required this.movie,
    required this.onAddCallback,
    required this.onPlayCallback,
    required this.onDetailCallback,
  });

  @override
  Widget build(BuildContext context) {
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 16, top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: movie.imagePath != null
                          ? Image.network(
                              ImageUtils.IMAGE_185 + movie.imagePath!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(ImageUtils.MOVIE_TEMP),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8, top: 20),
                          child: Text(
                            movie.title,
                            maxLines: 1,
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
                            movie.overview ?? '',
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
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconTextColumn(
                      icon: Icon(Icons.add, color: Colors.white),
                      label: 'Add',
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconedCircularButton(
                      icon: Icon(Icons.play_arrow),
                      label: 'Play',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconTextColumn(
                      icon: Icon(Icons.info_outlined, color: Colors.white),
                      label: 'Detail',
                      onPress: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showInfoBottomSheet(
  BuildContext context, {
  required Movie movie,
  required VoidCallback onAddCallback,
  required VoidCallback onPlayCallback,
  required VoidCallback onDetailCallback,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return MiniDetailBottomSheet(
        movie: movie,
        onAddCallback: onAddCallback,
        onPlayCallback: onPlayCallback,
        onDetailCallback: onDetailCallback,
      );
    },
  );
}
