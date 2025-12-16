import 'package:flutter/material.dart';

class Classroom extends StatelessWidget {
  const Classroom({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      {
        "title": "XML và ứng dụng - Nhóm 1",
        "code": "2025-2026.1.TIN4583.001",
        "students": "58 học viên",
        "image": "/images/nen1.jpg",
      },
      {
        "title": "Lập trình ứng dụng cho các thiết bị di động",
        "code": "2025-2026.1.TIN4403.006",
        "students": "55 học viên",
        "image": "/images/nen2.jpg",
      },
      {
        "title": "Lập trình ứng dụng cho các thiết bị di động",
        "code": "2025-2026.1.TIN4403.005",
        "students": "52 học viên",
        "image": "/images/nen3.webp",
      },
      {
        "title": "Lập trình ứng dụng cho các thiết bị di động",
        "code": "2025-2026.1.TIN4403.004",
        "students": "50 học viên",
        "image": "/images/nen2.jpg",
      },
      {
        "title": "Lập trình ứng dụng cho các thiết bị di động",
        "code": "2025-2026.1.TIN4403.003",
        "students": "52 học viên",
        "image": "/images/nen1.jpg",
      },
    ];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final c = classes[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    c["image"]!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.2),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c["title"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c["code"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c["students"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.more_vert, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
