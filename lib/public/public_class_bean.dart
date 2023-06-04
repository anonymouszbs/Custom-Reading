
///书籍信息bean

class BookInfoMap {
  BookInfoMap({
     this.ietmId,
     this.ietmName,
     this.parentnodeid,
     this.userNick,
     this.createTime,
     this.introduction,
     this.learningRate,
  });

  factory BookInfoMap.fromJson(Map json) {
    return BookInfoMap(
      ietmId: json['ietm_id'],
      ietmName: json['ietm_name'],
      parentnodeid: json['parentnodeid'],
      userNick: json['user_nick'],
      createTime: json['CreateTime'],
      introduction: json['Introduction'],
      learningRate: json['LearningRate'],
    );
  }

  final int? ietmId;
  final String? ietmName;
  final String? parentnodeid;
  final String? userNick;
  final String? createTime;
  final String? introduction;
  final int? learningRate;

  Map<String, dynamic> toJson() {
    return {
      'ietm_id': ietmId,
      'ietm_name': ietmName,
      'parentnodeid': parentnodeid,
      'user_nick': userNick,
      'CreateTime': createTime,
      'Introduction': introduction,
      'LearningRate': learningRate,
    };
  }

  BookInfoMap copyWith({
    int? ietmId,
    String? ietmName,
    String? parentnodeid,
    String? userNick,
    String? createTime,
    String? introduction,
    int? learningRate,
  }) {
    return BookInfoMap(
      ietmId: ietmId ?? this.ietmId,
      ietmName: ietmName ?? this.ietmName,
      parentnodeid: parentnodeid ?? this.parentnodeid,
      userNick: userNick ?? this.userNick,
      createTime: createTime ?? this.createTime,
      introduction: introduction ?? this.introduction,
      learningRate: learningRate ?? this.learningRate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookInfoMap &&
          runtimeType == other.runtimeType &&
          ietmId == other.ietmId &&
          ietmName == other.ietmName &&
          parentnodeid == other.parentnodeid &&
          userNick == other.userNick &&
          createTime == other.createTime &&
          introduction == other.introduction &&
          learningRate == other.learningRate;

  @override
  int get hashCode => Object.hashAll([
        ietmId,
        ietmName,
        parentnodeid,
        userNick,
        createTime,
        introduction,
        learningRate,
      ]);
}


///教材资源bean
class SourceMap {
  SourceMap({
    required this.id,
    required this.progress,
    required this.cfi,
    required this.duration,
    required this.filepath
  });
  factory SourceMap.fromJson(Map json) {
    return SourceMap(
      id: json['id'],
      progress: json['progress'],
      cfi: json['cfi'],
      duration: json['duration'],
      filepath:json["filepath"]
    );
  }
  final int id;
  final double progress;
  final List<String> cfi;
  final int duration;
  final String? filepath;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'progress': progress,
      'cfi': cfi,
      'duration': duration,
      'filepath': filepath,
    };
  }
  SourceMap copyWith({
    int? id,
    double? progress,
    List<String>? cfi,
    int? duration,
    String? filepath
  }) {
    return SourceMap(
      id: id ?? this.id,
      progress: progress ?? this.progress,
      cfi: cfi ?? this.cfi,
      duration: duration ?? this.duration,
      filepath:filepath??this.filepath,
    );
  }

}
