import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/provider/productProvider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  //display initial data
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<ProductProvider>(context, listen: false).getData();
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }
  void apicall() {
    Provider.of<ProductProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('provider app'),
        ),
        body: Container(
          // height: 500,
          // width: 500,
          child: Column(
            children: [
              ElevatedButton(onPressed: apicall, child: Text('call api')),
              Consumer<ProductProvider>(builder: (context, value, child) {
                print('value${value.isLoading}');

                return value == null
                    ? Text('')
                    : value.isLoading == true
                        ? Center(
                            child: SpinKitFadingCircle(
                              color: Colors.deepPurple,
                              size: 80.0,
                            ),
                          )
                        : value.err != null
                            ? Center(
                                child: Text(
                                  'Error : ${value.err}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : Container(
                                height: 500,
                                width: 500,
                                child: ListView.builder(
                                    itemCount: value.productList.length,
                                    itemBuilder: (context, index) => ListTile(
                                          leading: CircleAvatar(
                                            // radius: 10,

                                            backgroundImage: NetworkImage(
                                                value.productList[index].image),
                                          ),
                                          title: Text(
                                              value.productList[index].title),
                                          trailing: Text(value
                                              .productList[index].price
                                              .toString()),
                                        )),
                              );
              })
            ],
          ),
        ));
    //   if (value.isLoading == true) {
    //     return Center(
    //       child: SpinKitFadingCircle(
    //         color: Colors.deepPurple,
    //         size: 80.0,
    //       ),
    //     );
    //   } else if (value.err != null) {
    //     Center(
    //       child: Text(
    //         'err${value.err}',
    //         style: TextStyle(color: Colors.black),
    //       ),
    //     );
    //   }
    //   return ListView.builder(
    //       itemCount: value.productList.length,
    //       itemBuilder: (context, index) => ListTile(
    //             leading: CircleAvatar(
    //               // radius: 10,
    //
    //               backgroundImage:
    //                   NetworkImage(value.productList[index].image),
    //             ),
    //             title: Text(value.productList[index].title),
    //             trailing: Text(value.productList[index].price.toString()),
    //           ));
    // }));
  }
}
