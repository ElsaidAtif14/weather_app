
import 'package:flutter/material.dart';

class FancySpinner extends StatefulWidget {
  final double size;
  const FancySpinner({this.size = 64, super.key});

  @override
  State<FancySpinner> createState() => _FancySpinnerState();
}

class _FancySpinnerState extends State<FancySpinner> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Transform.rotate(
            angle: _ctrl.value * 2 * 3.14159,
            child: CustomPaint(
              painter: _ArcPainter(),
              child: Center(child: Icon(Icons.sync, size: widget.size * 0.4, color: Colors.white70)),
            ),
          );
        },
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = Colors.white12;
    final paintFg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(colors: [Colors.cyan, Colors.blue]).createShader(Offset.zero & size);

    final rect = Offset.zero & size;
    canvas.drawArc(rect, 0, 2 * 3.14159, false, paintBg);
    canvas.drawArc(rect, -0.5, 2.0, false, paintFg); // جزء متحرك
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
