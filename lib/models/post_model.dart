import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String title;
  final String? link;
  final String? description;
  final String communityProfilePic;
  final List<String> upvotes;
  final List<String> downvotes;
  final int commentCount;
  final String userername;
  final String uid;
  final String type;
  final DateTime createdAt;
  final List<String> awards;
  Post({
    required this.id,
    required this.title,
    this.link,
    this.description,
    required this.communityProfilePic,
    required this.upvotes,
    required this.downvotes,
    required this.commentCount,
    required this.userername,
    required this.uid,
    required this.type,
    required this.createdAt,
    required this.awards,
  });

  Post copyWith({
    String? id,
    String? title,
    String? link,
    String? description,
    String? communityProfilePic,
    List<String>? upvotes,
    List<String>? downvotes,
    int? commentCount,
    String? userername,
    String? uid,
    String? type,
    DateTime? createdAt,
    List<String>? awards,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      description: description ?? this.description,
      communityProfilePic: communityProfilePic ?? this.communityProfilePic,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      commentCount: commentCount ?? this.commentCount,
      userername: userername ?? this.userername,
      uid: uid ?? this.uid,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
      'description': description,
      'communityProfilePic': communityProfilePic,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'commentCount': commentCount,
      'userername': userername,
      'uid': uid,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'awards': awards,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        id: map['id'] as String,
        title: map['title'] as String,
        link: map['link'] != null ? map['link'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : null,
        communityProfilePic: map['communityProfilePic'] as String,
        upvotes: List<String>.from((map['upvotes'] as List<String>)),
        downvotes: List<String>.from((map['downvotes'] as List<String>)),
        commentCount: map['commentCount'] as int,
        userername: map['userername'] as String,
        uid: map['uid'] as String,
        type: map['type'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
        awards: List<String>.from(
          (map['awards'] as List<String>),
        ),);
  }



  @override
  String toString() {
    return 'Post(id: $id, title: $title, link: $link, description: $description, communityProfilePic: $communityProfilePic, upvotes: $upvotes, downvotes: $downvotes, commentCount: $commentCount, userername: $userername, uid: $uid, type: $type, createdAt: $createdAt, awards: $awards)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.link == link &&
        other.description == description &&
        other.communityProfilePic == communityProfilePic &&
        listEquals(other.upvotes, upvotes) &&
        listEquals(other.downvotes, downvotes) &&
        other.commentCount == commentCount &&
        other.userername == userername &&
        other.uid == uid &&
        other.type == type &&
        other.createdAt == createdAt &&
        listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        link.hashCode ^
        description.hashCode ^
        communityProfilePic.hashCode ^
        upvotes.hashCode ^
        downvotes.hashCode ^
        commentCount.hashCode ^
        userername.hashCode ^
        uid.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        awards.hashCode;
  }
}
