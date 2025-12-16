import 'dart:math';
import 'package:flutter/material.dart';

class ChangeColorApp extends StatefulWidget {
  const ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}

class _ChangeColorAppState extends State<ChangeColorApp> {
  Color _backgroundColor = Colors.purple;
  String _colorName = "Tím";
  final List<Map<String, dynamic>> _colors = [
    {'name': 'Đỏ', 'color': Colors.red},
    {'name': 'Xanh lá', 'color': Colors.green},
    {'name': 'Xanh dương', 'color': Colors.blue},
    {'name': 'Vàng', 'color': Colors.yellow},
    {'name': 'Cam', 'color': Colors.orange},
    {'name': 'Tím', 'color': Colors.purple},
    {'name': 'Hồng', 'color': Colors.pink},
    {'name': 'Xám', 'color': Colors.grey},
    {'name': 'Nâu', 'color': Colors.brown},
  ];
  void _changeColor() {
    final random = Random();
    final newColor = _colors[random.nextInt(_colors.length)];
    setState(() {
      _backgroundColor = newColor['color'];
      _colorName = newColor['name'];
    });
  }
  void _resetColor() {
    setState(() {
      _backgroundColor = Colors.purple;
      _colorName = "Tím";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [         
            SizedBox(width: 8),
            Text('🎨 Ứng dụng Đổi màu nền',
            style: TextStyle(
              color: Colors.white,       
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Màu hiện tại',
              style: TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _colorName,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _changeColor,
                  icon: const Icon(Icons.palette, color: Colors.white),
                  label: const Text('Đổi màu',
                  style: TextStyle(
                  color: Colors.white,       
                  )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _resetColor,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text('Đặt lại',
                  style: TextStyle(
                  color: Colors.white,       
                  )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
