import 'package:car_rent_client/src/utils/json_parsers.dart';
import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String url;
  final String legende;
  final bool principale;
  final int ordre;

  final String? asset;

  const Photo({
    required this.url,
    required this.legende,
    required this.principale,
    required this.ordre,
    this.asset,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      url: json['url'] ?? '',
      legende: json['legende'] ?? '',
      principale: json['principale'] ?? false,
      ordre: parseInt(json['ordre']),
      asset: json['asset'],
    );
  }

  @override
  List<Object?> get props => [url, legende, principale, ordre, asset];
}
