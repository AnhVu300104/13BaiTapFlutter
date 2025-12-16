import 'package:flutter/material.dart';

class BMIApp extends StatefulWidget {
  const BMIApp({super.key});

  @override
  State<BMIApp> createState() => _BMIAppState();
}

class _BMIAppState extends State<BMIApp> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? bmi;
  String? category;

  void calculateBMI() {
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        bmi = null;
        category = "Dữ liệu không hợp lệ";
      });
      return;
    }

    final double result = weight / (height * height);
    bmi = double.parse(result.toStringAsFixed(2));

    if (bmi! < 18.5) {
      category = "Thiếu cân";
    } else if (bmi! < 25) {
      category = "Bình thường";
    } else if (bmi! < 30) {
      category = "Thừa cân";
    } else {
      category = "Béo phì";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tính chỉ số BMI",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Chiều cao (m)",
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cân nặng (kg)",
                    prefixIcon: Icon(Icons.line_weight), 
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                ElevatedButton.icon(
                  onPressed: calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  icon: const Icon(Icons.calculate_outlined,color: Colors.white,), 
                  label: const Text("Tính BMI",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 25),

                if (bmi != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chỉ số BMI: $bmi",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.red,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Phân loại: $category",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
