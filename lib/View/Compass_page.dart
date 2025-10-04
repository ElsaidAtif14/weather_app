import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class FancyCompass extends StatefulWidget {
  const FancyCompass({super.key});

  @override
  State<FancyCompass> createState() => _FancyCompassState();
}

class _FancyCompassState extends State<FancyCompass> {
  Position? _position;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final pos = await Geolocator.getCurrentPosition();
      setState(() => _position = pos);
    }
  }

  String _getDirectionLabel(double degree) {
    if (degree >= 337.5 || degree < 22.5) return "N";
    if (degree >= 22.5 && degree < 67.5) return "NE";
    if (degree >= 67.5 && degree < 112.5) return "E";
    if (degree >= 112.5 && degree < 157.5) return "SE";
    if (degree >= 157.5 && degree < 202.5) return "S";
    if (degree >= 202.5 && degree < 247.5) return "SW";
    if (degree >= 247.5 && degree < 292.5) return "W";
    return "NW";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final double? direction = snapshot.data?.heading;
        if (direction == null) {
          return const Center(child: Text("No Compass Sensor Found"));
        }

        final String dirLabel = _getDirectionLabel(direction);
        final int degree = direction.round();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // النص الكبير اللي فوق
            Text(
              "$dirLabel$degree°",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // البوصلة
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Transform.rotate(
                angle: (direction * (math.pi / 180) * -1),
                child: CustomPaint(
                  painter: _CompassPainter(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // الإحداثيات
            if (_position != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("NL",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text(
                        "${_position!.latitude.toStringAsFixed(4)}°",
                        style:
                        const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Column(
                    children: [
                      const Text("EL",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text(
                        "${_position!.longitude.toStringAsFixed(4)}°",
                        style:
                        const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              )
            ]
          ],
        );
      },
    );
  }
}

// يرسم الأرقام + الاتجاهات الكبيرة
class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint tickPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    for (int i = 0; i < 360; i += 30) {
      final double angle = (i * math.pi / 180);

      // مكان الخطوط
      final Offset start = Offset(
        center.dx + (radius - 10) * math.cos(angle),
        center.dy + (radius - 10) * math.sin(angle),
      );
      final Offset end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, tickPaint);

      // النصوص (0, 30, 60 …)
      textPainter.text = TextSpan(
        text: "$i",
        style: const TextStyle(color: Colors.white, fontSize: 12),
      );
      textPainter.layout();
      final Offset textOffset = Offset(
        center.dx + (radius - 25) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius - 25) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }

    // الاتجاهات الأربعة الأساسية
    final directions = {
      "N": Colors.red,
      "E": Colors.white,
      "S": Colors.white,
      "W": Colors.white,
    };

    directions.forEach((dir, color) {
      double angle;
      switch (dir) {
        case "N":
          angle = -90 * math.pi / 180;
          break;
        case "E":
          angle = 0;
          break;
        case "S":
          angle = 90 * math.pi / 180;
          break;
        case "W":
          angle = 180 * math.pi / 180;
          break;
        default:
          angle = 0;
      }

      textPainter.text = TextSpan(
        text: dir,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      final Offset textOffset = Offset(
        center.dx + (radius - 45) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius - 45) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}