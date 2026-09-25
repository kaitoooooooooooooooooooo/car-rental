import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String url;
  final String legende;
  final bool principale;
  final int ordre;

  const Photo({
    required this.url,
    required this.legende,
    required this.principale,
    required this.ordre,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      url: json['url'] as String,
      legende: json['legende'] as String,
      principale: json['principale'] as bool,
      ordre: json['ordre'] as int,
    );
  }

  @override
  List<Object?> get props => [url, legende, principale, ordre];
}
