import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar Heatmap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HeatmapPage(),
    );
  }
}

class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  // Example data for heatmap: {Date: Value}
  final Map<String, int> data = const {
    "2024-11-01": 3,
    "2024-11-02": 5,
    "2024-11-03": 8,
    "2024-11-04": 0,
    "2024-11-05": 7,
    "2024-11-06": 2,
    "2024-11-07": 6,
  };

  // Max value for determining color intensity
  final int maxValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Heatmap"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 7 days in a week
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: 30, // Assume 30 days in the month
          itemBuilder: (context, index) {
            // Create a date string for the heatmap
            String date = "2024-11-${(index + 1).toString().padLeft(2, '0')}";

            // Get the value for the date (default is 0 if not in data)
            int value = data[date] ?? 0;

            // Determine the color intensity based on the value
            double intensity = value / maxValue;

            return GestureDetector(
              onTap: () {
                // Show details on tap
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Date: $date, Value: $value")),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.lerp(Colors.white, Colors.blue, intensity),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
