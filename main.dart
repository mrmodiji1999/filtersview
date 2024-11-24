import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Instagram Filter Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.red),
        home: FilterPage(),
      );
}

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final String imagePath = 'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80'; 
  final List<String> filters = ['Normal', 'Sepia', 'Grayscale', 'Invert']; 
  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Filters view'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: applyFilter(selectedFilterIndex),
              ),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setState(() => selectedFilterIndex = index),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedFilterIndex == index
                                ? Colors.red
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: applyFilter(index, isThumbnail: true),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        filters[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedFilterIndex == index
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget applyFilter(int filterIndex, {bool isThumbnail = false}) {
  switch (filterIndex) {
      case 1: // Sepia
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.brown.withOpacity(0.5),
            BlendMode.modulate,
          ),
          child: Image.network(imagePath, fit: BoxFit.cover),
        );
      case 2: // Grayscale
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            0.2126, 0.7152, 0.0722, 0, 0, // R
            0.2126, 0.7152, 0.0722, 0, 0, // G
            0.2126, 0.7152, 0.0722, 0, 0, // B
            0, 0, 0, 1, 0, // Alpha
          ]),
          child: Image.network(imagePath, fit: BoxFit.cover),
        );
      case 3: // Invert
        return ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            -1, 0, 0, 0, 255, // R
            0, -1, 0, 0, 255, // G
            0, 0, -1, 0, 255, // B
            0, 0, 0, 1, 0, // Alpha
          ]),
          child: Image.network(imagePath, fit: BoxFit.cover),
        );
      default: // Normal
        return Image.network(
          imagePath,
          fit: isThumbnail ? BoxFit.cover : BoxFit.contain,
        );
    }
  }
}
