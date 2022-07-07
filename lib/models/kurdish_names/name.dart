import 'dart:convert';

class Name {
  int? nameId;
  String? name;
  String? desc;
  String? gender;
  int? positiveVotes;
  int? negativeVotes;

  Name({
    this.nameId,
    this.name,
    this.desc,
    this.gender,
    this.positiveVotes,
    this.negativeVotes,
  });

  factory Name.fromMap(Map<String, dynamic> data) => Name(
        nameId: data['nameId'] as int?,
        name: data['name'] as String?,
        desc: data['desc'] as String?,
        gender: data['gender'] as String?,
        positiveVotes: data['positive_votes'] as int?,
        negativeVotes: data['negative_votes'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'nameId': nameId,
        'name': name,
        'desc': desc,
        'gender': gender,
        'positive_votes': positiveVotes,
        'negative_votes': negativeVotes,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Name].
  factory Name.fromJson(String data) {
    return Name.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Name] to a JSON string.
  String toJson() => json.encode(toMap());
}
