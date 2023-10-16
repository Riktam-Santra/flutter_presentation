import 'package:flutter/material.dart';
import 'package:flutter_presentation/providers/slide_index_provider.dart';
import 'package:flutter_presentation/slides/slide_one.dart';
import 'package:flutter_presentation/slides/slide_two.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Main(),
      ),
    ),
  );
}

final indexList = [
  Builder(builder: (context) {
    return SlideOne(
      size: MediaQuery.of(context).size,
    );
  }),
  Builder(builder: (context) {
    return SlideTwo(
      size: MediaQuery.of(context).size,
    );
  })
];

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return indexList[ref.watch(slideIndexProvider)];
    });
  }
}
