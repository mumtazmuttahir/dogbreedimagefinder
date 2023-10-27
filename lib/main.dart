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
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      appBar: PlatformAppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PlatformTextButton(
                child: const Text("Breed"),
                onPressed: () {},
              ),
              // FadeInImage.memoryNetwork(
              //   placeholder: 'https://picsum.photos/250?image=9',
              //   image: 'https://picsum.photos/250?image=9',
              // ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                  width: 100,
                  height: 100,
                  // color: Colors.grey,
                ),
              ),
              const Divider(
                height: 10,
              ),
              PlatformTextButton(
                child: const Text("Images list for Breed: "),
                onPressed: () {},
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                        width: 100,
                        height: 100,
                        // color: Colors.grey,
                      ),
                    );
                    // return TextButton(
                    //   onPressed: null,
                    //   child: Text("$index"),
                    // );
                  },
                ),
              ),
              const Divider(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: const <Widget>[
    //         Text(
    //           'You have pushed the button this many times:',
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => {},
    //     tooltip: 'Increment',
    //     child: const Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
