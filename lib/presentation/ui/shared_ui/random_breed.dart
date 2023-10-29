import 'dart:io';

import 'package:dogbreedimagefinder/data_sources/network/dog_breed_source.dart';
import 'package:dogbreedimagefinder/domain/entities/breed.dart';
import 'package:dogbreedimagefinder/presentation/ui/shared_ui/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class RandomBreedSection extends StatefulWidget {
  const RandomBreedSection({super.key});

  @override
  State<RandomBreedSection> createState() => _RandomBreedSectionState();
}

class _RandomBreedSectionState extends State<RandomBreedSection> {
  // late Future<RandomBreed> fetchRandomBreed;

  late Future<String> fetchRandomImageByBreed;
  double kItemExtent = 32.0;
  int selectedBreed = 0;

  @override
  void initState() {
    super.initState();

    fetchRandomImageByBreed =
        DogApi().fetchRandomImageByBreed(DogApi().dogBreedList[selectedBreed]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Random image by breed
        PlatformTextButton(
          child: Text("Breed: ${DogApi().dogBreedList[selectedBreed]}"),
          onPressed: () {
            // setState(() {
            //   fetchRandomImageByBreed = DogApi()
            //       .fetchRandomImageByBreed(DogApi().dogBreedList[indexValue]);
            // });
            if (Platform.isIOS) {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 500,
                  padding: const EdgeInsets.only(top: 6.0),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: SafeArea(
                    top: false,
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: kItemExtent,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedBreed,
                      ),
                      onSelectedItemChanged: (int selectedItem) {
                        setState(
                          () {
                            selectedBreed = selectedItem;
                            // dropDownBreedValue =
                            //     snapshot.data![selectedItem];
                            // dogsList = helper.listDogsByID(
                            //     snapshot.data![selectedItem].id,
                            //     sizeValues[_selectedSize]);
                            fetchRandomImageByBreed = DogApi()
                                .fetchRandomImageByBreed(
                                    DogApi().dogBreedList[selectedBreed]);
                          },
                        );
                      },
                      children: List<Widget>.generate(
                        DogApi().dogBreedList.length,
                        (int index) {
                          return Center(
                            child: Text(DogApi().dogBreedList[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            } else {
              DropdownButton<String>(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: const Text('Breed'),
                value: DogApi().dogBreedList[selectedBreed],
                items: DogApi()
                    .dogBreedList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedBreed = DogApi().dogBreedList.indexOf(value!);
                },
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<String>(
            future: fetchRandomImageByBreed,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  snapshot.data!,
                  width: 120,
                  height: 100,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const SizedBox(
                width: 120,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        const CustomDivider(height: 10),
      ],
    );
  }
}
