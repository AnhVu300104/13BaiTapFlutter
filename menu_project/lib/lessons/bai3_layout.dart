import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.notifications, size: 36),
                    SizedBox(width: 15),
                    Icon(Icons.extension, size: 36),
                  ],
                ),

                const SizedBox(height: 25),
                const Text(
                  "Welcome,",
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Charlie",
                  style: TextStyle(
                    fontSize: 52,
                  ),
                ),

                const SizedBox(height: 25),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 105),
                const Text(
                  "Saved Places",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isDesktop ? 4 : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: isDesktop ? 1.4 : 1,
                  children: const [
                    PlaceCard("images/anh1.jpg"),
                    PlaceCard("images/anh2.jpg"),
                    PlaceCard("images/anh1.jpg"),
                    PlaceCard("images/anh2.jpg"),
                    PlaceCard("images/anh2.jpg"),
                    PlaceCard("images/anh1.jpg"),
                    PlaceCard("images/anh2.jpg"),
                    PlaceCard("images/anh1.jpg"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String imageUrl;
  const PlaceCard(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}