import 'dart:convert';

import 'package:car_rent_client/src/features/car/data/remote/car_service.dart';
import 'package:car_rent_client/src/features/car/domain/localisation.dart';
import 'package:car_rent_client/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CarLocationMap extends StatefulWidget {
  const CarLocationMap({
    super.key,
    required this.carId,
    required this.localisation,
  });

  final String carId;
  final Localisation localisation;

  @override
  State<CarLocationMap> createState() => _CarLocationMapState();
}

class _CarLocationMapState extends State<CarLocationMap> {
  GoogleMapController? mapController;

  final Set<Marker> markers = {};

  String? error;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      final response = await http.get(
        Uri.parse('$url/cars/${widget.carId}/location'),
      );

      if (response.statusCode != 200) {
        throw Exception('Erreur serveur : ${response.statusCode}');
      }

      final location = jsonDecode(response.body);

      final position = LatLng(
        (location['lat'] as num).toDouble(),
        (location['lng'] as num).toDouble(),
      );

      setState(() {
        markers.clear();

        markers.add(
          Marker(
            markerId: const MarkerId('location'),
            position: position,
            infoWindow: InfoWindow(
              title: widget.localisation.pointRetrait,
              snippet: widget.localisation.adresse,
            ),
          ),
        );
      });

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 16),
        ),
      );
    } catch (e) {
      if (mounted) {
        setState(() => error = 'Location unavailable');
      }
    }
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localisation = widget.localisation;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: error != null
                ? Center(
                    child: Text(
                      error!,
                      style: GoogleFonts.manrope(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  )
                : GoogleMap(
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(46.8182, 8.2275),
                      zoom: 7,
                    ),
                    markers: markers,
                    mapType: MapType.normal,
                    zoomControlsEnabled: true,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: AppColors.accentLight,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localisation.pointRetrait,
                        style: GoogleFonts.manrope(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${localisation.adresse}, '
                        '${localisation.codePostal} '
                        '${localisation.ville}',
                        style: GoogleFonts.manrope(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
