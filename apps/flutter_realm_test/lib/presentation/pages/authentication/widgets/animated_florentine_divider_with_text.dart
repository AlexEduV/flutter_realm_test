import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedTiledDivider extends StatefulWidget {
  final String text;
  final String ornamentAsset;
  const AnimatedTiledDivider({required this.text, required this.ornamentAsset, super.key});

  @override
  State<AnimatedTiledDivider> createState() => _AnimatedTiledDividerState();
}

class _AnimatedTiledDividerState extends State<AnimatedTiledDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  ui.Image? _ornamentImage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    loadImage(widget.ornamentAsset).then((img) {
      setState(() {
        _ornamentImage = img;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSide() {
    return Expanded(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return SizedBox(
            height: 32, // Adjust as needed
            child: CustomPaint(painter: TiledDividerPainter(_ornamentImage, _animation.value)),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildSide(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.text, style: Theme.of(context).textTheme.titleMedium),
          ),
          _buildSide(),
        ],
      ),
    );
  }

  Future<ui.Image> loadImage(String asset) async {
    final data = await rootBundle.load(asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }
}

class TiledDividerPainter extends CustomPainter {
  final ui.Image? ornamentImage;
  final double widthFactor; // 0.0 to 1.0

  TiledDividerPainter(this.ornamentImage, this.widthFactor);

  @override
  void paint(Canvas canvas, Size size) {
    if (ornamentImage == null) return;

    final paint = Paint();
    final ornamentWidth = ornamentImage!.width.toDouble();
    final ornamentHeight = ornamentImage!.height.toDouble();
    final scale = size.height / ornamentHeight;
    final scaledOrnamentWidth = ornamentWidth * scale;
    final totalWidth = size.width * widthFactor;

    double x = 0;
    while (x < totalWidth) {
      canvas.save();
      canvas.translate(x, 0);
      canvas.scale(scale, scale);
      canvas.drawImage(ornamentImage!, const Offset(0, 0), paint);
      canvas.restore();
      x += scaledOrnamentWidth;
    }
  }

  @override
  bool shouldRepaint(covariant TiledDividerPainter oldDelegate) =>
      oldDelegate.ornamentImage != ornamentImage || oldDelegate.widthFactor != widthFactor;
}
