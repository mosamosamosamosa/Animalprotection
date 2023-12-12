import 'dart:developer';

import 'package:anitection/providers/animal.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimalSearchResultScreen extends ConsumerStatefulWidget {
  const AnimalSearchResultScreen(
      {super.key,
      required this.animalKind,
      required this.size,
      required this.hairLength,
      required this.age,
      required this.patternIds
      });

  final String animalKind;
  final List<String> size;
  final List<String>? hairLength;
  final List<Age>? age;
  final List<int>? patternIds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalSearchResultState();
  }
}

class AnimalSearchResultState extends ConsumerState<AnimalSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final searchResult = ref.watch(searchAnimalFutureProvider(AnimalSearchQueries(
      animalKind: widget.animalKind,
      size: widget.size,
      hairLength: widget.hairLength,
      age: widget.age,
      patternIds: widget.patternIds,
    )));
    return Scaffold(
      body: searchResult.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final animal = data.data[index];
              return ListTile(
                title: Text(animal.attributes.name ?? ""),
              );
            },
            itemCount: data.data.length,
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          log("error: $error, stackTrace: $stackTrace", error: error, stackTrace: stackTrace);
          return Center(
            child: Text("エラーが発生しました:$error, $stackTrace"),
          );
        },
      )
    );
  }
}

