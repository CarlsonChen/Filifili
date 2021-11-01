class HomeMo {
  List<BannerMo>? bannerList;
  List<CategoryMo>? categoryList;
  late List<VideoMo> videoList;

  HomeMo({this.bannerList, this.categoryList, required this.videoList});

  HomeMo.fromJson(Map<String, dynamic> json) {
    if (json['bannerList'] != null) {
      bannerList = List<BannerMo>.empty(growable: true);
      json['bannerList'].forEach((v) {
        bannerList!.add(BannerMo.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = List<CategoryMo>.empty(growable: true);
      json['categoryList'].forEach((v) {
        categoryList!.add(CategoryMo.fromJson(v));
      });
    }
    if (json['videoList'] != null) {
      videoList = List<VideoMo>.empty(growable: true);
      json['videoList'].forEach((v) {
        videoList.add(VideoMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (bannerList != null) {
      data['bannerList'] = this.bannerList!.map((v) => v.toJson()).toList();
    }
    if (categoryList != null) {
      data['categoryList'] = this.categoryList!.map((v) => v.toJson()).toList();
    }
    if (videoList != null) {
      data['videoList'] = videoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerMo {
  late String id;
  late int sticky;
  late String type;
  late String title;
  late String subtitle;
  late String url;
  late String cover;
  late String createTime;

  // BannerMo(
  //     {this.id,
  //       this.sticky,
  //       this.type,
  //       this.title,
  //       this.subtitle,
  //       this.url,
  //       this.cover,
  //       this.createTime});

  BannerMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sticky = json['sticky'];
    type = json['type'];
    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
    cover = json['cover'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['sticky'] = sticky;
    data['type'] = type;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['url'] = url;
    data['cover'] = cover;
    data['createTime'] = createTime;
    return data;
  }
}

class CategoryMo {
  late String name;
  late int count;

  // CategoryMo({this.name, this.count});

  CategoryMo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}

class VideoMo {
  late String id;
  late String vid;
  late String title;
  late String tname;
  String? url;
  late String cover;
  late int pubdate;
  late String desc;
  late int view;
  late int duration;
  Owner? owner;
  late int reply;
  late int favorite;
  late int like;
  late int coin;
  late int share;
  late String createTime;
  late int size;

  VideoMo({
    required this.vid,
  });

  VideoMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vid = json['vid'];
    title = json['title'];
    tname = json['tname'];
    url = json['url'];
    cover = json['cover'];
    pubdate = json['pubdate'];
    desc = json['desc'];
    view = json['view'];
    duration = json['duration'];
    owner = (json['owner'] != null ? Owner.fromJson(json['owner']) : null)!;
    reply = json['reply'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    share = json['share'];
    createTime = json['createTime'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vid'] = this.vid;
    data['title'] = this.title;
    data['tname'] = this.tname;
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['pubdate'] = this.pubdate;
    data['desc'] = this.desc;
    data['view'] = this.view;
    data['duration'] = this.duration;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['reply'] = this.reply;
    data['favorite'] = this.favorite;
    data['like'] = this.like;
    data['coin'] = this.coin;
    data['share'] = this.share;
    data['createTime'] = this.createTime;
    data['size'] = this.size;
    return data;
  }
}

class Owner {
  String name;
  String face;
  int fans;

  Owner({this.name, this.face, this.fans});

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    return data;
  }
}
