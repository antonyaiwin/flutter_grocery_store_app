import 'dart:convert';

class RecentSearchModel {
  String? text;
  DateTime? createdData;
  RecentSearchModel({
    this.text,
    this.createdData,
  });

  RecentSearchModel copyWith({
    String? text,
    DateTime? createdData,
  }) {
    return RecentSearchModel(
      text: text ?? this.text,
      createdData: createdData ?? this.createdData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'createdData': createdData?.millisecondsSinceEpoch,
    };
  }

  factory RecentSearchModel.fromMap(Map<String, dynamic> map) {
    return RecentSearchModel(
      text: map['text'] != null ? map['text'] as String : null,
      createdData: map['createdData'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdData'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentSearchModel.fromJson(String source) =>
      RecentSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RecentSearchModel(text: $text, createdData: $createdData)';
}
