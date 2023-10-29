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
  late Future<RandomBreed> fetchRandomBreed;
  @override
  void initState() {
    super.initState();
    fetchRandomBreed = DogApi().fetchRandomImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Random image by breed
        PlatformTextButton(
          child: const Text("Breed"),
          onPressed: () {
            setState(() {
              fetchRandomBreed = DogApi().fetchRandomImage();
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<RandomBreed>(
            future: fetchRandomBreed,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  snapshot.data!.message!,
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
