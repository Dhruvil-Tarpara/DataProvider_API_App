import 'package:dataprovider/globals/global.dart';
import 'package:dataprovider/helpers/api_helpers.dart';
import 'package:dataprovider/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xfffaf7ed),
        actions: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                onSubmitted: (val) {
                  setState(() {
                    Global.searchData = int.parse(val) - 1;
                  });
                },
                placeholder: "Search Id",
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton(
              color: Colors.white,
              elevation: 2,
              onSelected: (val) {
                setState(() {
                  Global.endpoint = val;
                  Global.title = val;
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: "/post",
                    child: Text("Post"),
                  ),
                  const PopupMenuItem(
                    value: "/comments",
                    child: Text("Comments"),
                  ),
                  const PopupMenuItem(
                    value: "/albums",
                    child: Text("Albums"),
                  ),
                  const PopupMenuItem(
                    value: "/photos",
                    child: Text("Photos"),
                  ),
                  const PopupMenuItem(
                    value: "/todos",
                    child: Text("Todos"),
                  ),
                  const PopupMenuItem(
                    value: "/users",
                    child: Text("User"),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfffaf7ed),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                  ),
                  child: Text(
                    "{${Global.title.substring(1).toUpperCase()}}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: ApiHelpers.apiHelpers.getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error is : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Provider>? data = snapshot.data;
                    return (data != null)
                        ? (Global.searchData.toInt() < data.length)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Card(
                                              color: const Color(0xfffbf1a3),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12),
                                                child: Text(
                                                  "${data[Global.searchData].id}",
                                                  style: const TextStyle(
                                                    color: Colors.deepPurpleAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              color: const Color(0xffb3ddc6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12),
                                                child:(Global.endpoint != '/users')?Text(
                                                 data[Global.searchData].userid.toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurpleAccent,
                                                    fontSize: 14,
                                                  ),
                                                ):Text(
                                                  data[Global.searchData].username,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurpleAccent,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data[Global.searchData].title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text("Invalid Search id ..."),
                              )
                        : const Center(
                            child: Text("Data is Not Founds ...."),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
