import 'package:dogbreedimagefinder/data_sources/network/dog_breed_source.dart';
import 'package:dogbreedimagefinder/domain/entities/breed.dart';
import 'package:dogbreedimagefinder/presentation/ui/shared_ui/random_breed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Flutter Demo',
      material: (_, __) => MaterialAppData(
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
        ),
      ),
      cupertino: (_, __) => CupertinoAppData(
        theme: const CupertinoThemeData(
          primaryColor: Colors.blue,
        ),
      ),
      home: const MyHomePage(title: 'Dog Breeds'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<RandomBreed> fetchRandomBreed;
  late Future<List<String>> dogList;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    dogList = DogApi().fetchAllDogBreeds();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      appBar: PlatformAppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: SafeArea(
            child: FutureBuilder(
                future: dogList,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        //Random image by breed
                        RandomBreedSection(),
                        //Image list from a breed
                        // PlatformTextButton(
                        //   child: const Text("Images list for Breed: "),
                        //   onPressed: () {},
                        // ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 150,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 5,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(16.0),
                        //         child: Image.network(
                        //           'https://picsum.photos/250?image=9',
                        //           width: 100,
                        //           height: 100,
                        //           // color: Colors.grey,
                        //         ),
                        //       );
                        //       // return TextButton(
                        //       //   onPressed: null,
                        //       //   child: Text("$index"),
                        //       // );
                        //     },
                        //   ),
                        // ),
                        // const Divider(
                        //   height: 10,
                        // ),
                        // //Random image by breed
                        // PlatformTextButton(
                        //   child: const Text("Breed"),
                        //   onPressed: () {},
                        // ),
                        // // FadeInImage.memoryNetwork(
                        // //   placeholder: 'https://picsum.photos/250?image=9',
                        // //   image: 'https://picsum.photos/250?image=9',
                        // // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Image.network(
                        //     'https://picsum.photos/250?image=9',
                        //     width: 100,
                        //     height: 100,
                        //     // color: Colors.grey,
                        //   ),
                        // ),
                        // const Divider(
                        //   height: 10,
                        // ),
                        // //Image list from a breed
                        // PlatformTextButton(
                        //   child: const Text("Images list for Breed: "),
                        //   onPressed: () {},
                        // ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 150,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 5,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(16.0),
                        //         child: Image.network(
                        //           'https://picsum.photos/250?image=9',
                        //           width: 100,
                        //           height: 100,
                        //           // color: Colors.grey,
                        //         ),
                        //       );
                        //       // return TextButton(
                        //       //   onPressed: null,
                        //       //   child: Text("$index"),
                        //       // );
                        //     },
                        //   ),
                        // ),
                        // const Divider(
                        //   height: 10,
                        // ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }))),
      ),
    );
  }
}
