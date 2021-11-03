import 'package:bilibili/model/home_tab_mo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoMo model;

  const VideoCard(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Container(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                model.cover,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Text(
                    model.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        model.owner!.face,
                        height: 20,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      model.owner!.name,
                    )),
                    Icon(
                      Icons.more_vert_sharp,
                      size: 15,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
