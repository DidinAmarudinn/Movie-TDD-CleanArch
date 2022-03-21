import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter/material.dart';

class SeasonCardList extends StatelessWidget {
  final Season season;
  const SeasonCardList({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      margin: EdgeInsets.only(bottom:kDefaultPadding / 3),
      padding: EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: '$BASE_IMAGE_URL${season.posterPath}',
              width: 70,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          SizedBox(
            width: kDefaultPadding / 2,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      season.name ?? "-",
                      style: kHeading6,
                    ),
                    SizedBox(width: kDefaultPadding/6,),
                    Text("("+(season.episodeCount ?? 0).toString()+" Episode)",style: kBodyText,)
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 3,
                ),
                Flexible(
                        child: Text(
                          season.overview ?? "_",
                          style: kBodyText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
