
import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  int selectedStar = 5;

  void sendFeedback() {
    String name = nameController.text.trim();
    String content = contentController.text.trim();

    if (name.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Đã gửi phản hồi cho: $name (⭐ $selectedStar sao)"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true, 
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Gửi phản hồi",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Họ tên",
                prefixIcon: Icon(Icons.person_outline,),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            DropdownButtonFormField<int>(
              value: selectedStar,
              decoration: const InputDecoration(
                labelText: "Đánh giá (1 - 5 sao)",
                prefixIcon: Icon(Icons.star_border), 
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                5,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Row(
                    children: [
                      Text("${index + 1} sao"),
                    ],
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedStar = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: contentController,
              minLines: 6,        
              maxLines: 12,
              decoration: const InputDecoration(
                labelText: "Nội dung góp ý",
                prefixIcon: Icon(Icons.feedback_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: ElevatedButton.icon(
                onPressed: sendFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                icon: const Icon(Icons.send,color: Colors.white,), 
                label: const Text(
                  "Gửi phản hồi",
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
