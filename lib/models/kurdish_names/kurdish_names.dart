import 'dart:convert';

import 'name.dart';

class KurdishNames {
  List<Name>? names;
  int? recordCount;

  KurdishNames({this.names, this.recordCount});

  factory KurdishNames.fromMap(Map<String, dynamic> data) => KurdishNames(
        names: (data['names'] as List<dynamic>?)
            ?.map((e) => Name.fromMap(e as Map<String, dynamic>))
            .toList(),
        recordCount: data['recordCount'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'names': names?.map((e) => e.toMap()).toList(),
        'recordCount': recordCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [KurdishNames].
  factory KurdishNames.fromJson(String data) {
    return KurdishNames.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [KurdishNames] to a JSON string.
  String toJson() => json.encode(toMap());
}
