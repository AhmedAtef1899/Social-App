class SocialCommentModel {
  final String comment;
  final String commenterId;
  final DateTime timestamp;

  SocialCommentModel({
    required this.comment,
    required this.commenterId,
    required this.timestamp,
  });

  factory SocialCommentModel.fromJson(Map<String, dynamic> json) {
    return SocialCommentModel(
      comment: json['comment'],
      commenterId: json['commenterId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'commenterId': commenterId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
