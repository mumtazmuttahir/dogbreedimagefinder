import 'dart:io';
import 'package:dogbreedimagefinder/data_sources/network/dog_breed_source.dart';
import 'package:dogbreedimagefinder/domain/entities/breed.dart';
import 'package:dogbreedimagefinder/presentation/ui/shared_ui/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageListByBreedSection extends StatefulWidget {
  const ImageListByBreedSection({super.key});

  @override
  State<ImageListByBreedSection> createState() =>
      _ImageListByBreedSectionState();
}

class _ImageListByBreedSectionState extends State<ImageListByBreedSection> {
  late Future<List<String>> fetchImageListByBreed;
  double kItemExtent = 32.0;
  int selectedBreed = 0;
  @override
  void initState() {
    super.initState();
    fetchImageListByBreed =
        DogApi().fetchImageListByBreed(DogApi().dogBreedList[selectedBreed]);
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
                            fetchImageListByBreed = DogApi()
                                .fetchImageListByBreed(
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
          child: FutureBuilder<List<String>>(
            future: fetchImageListByBreed,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                print("images list");
                print(snapshot.data!.length);
                // for (int i = 0; i < snapshot.data!.length; i++) {
                //   print("$i -> ${snapshot.data![i]}");
                // }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.network(
                          snapshot.data![index],
                          width: 100,
                          height: 100,
                          // color: Colors.grey,
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              print(snapshot.connectionState);
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
