import 'package:flutter/material.dart';
import 'package:shijmmer_loading_smaple/data/data.dart';
import 'package:shijmmer_loading_smaple/model/food.dart';
import 'package:shijmmer_loading_smaple/widget/shimmerWidget.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<Food> foods = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2), () {});
    foods = List.of(allFoods);

    foods = List.of(allFoods);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildEffect(),
        centerTitle: true,
        actions: [IconButton(onPressed: loadData, icon: Icon(Icons.sync))],
      ),
      body: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            if (isLoading) {
              return buildFoodShimmer();
            } else {
              final food = foods[index];

              return buildFood(food);
            }
          }),
    );
  }

  Widget buildFood(Food food) => ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(food.urlImage),
        ),
        title: Text(
          food.title,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          food.description,
          style: TextStyle(fontSize: 14),
        ),
      );

  Widget buildFoodShimmer() => ListTile(
        leading: ShimmerWidget.circular(
          width: 64,
          height: 64,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
              width: MediaQuery.of(context).size.width * .3, height: 16),
        ),
        subtitle: ShimmerWidget.rectangular(height: 14),
      );

  Widget buildEffect() => Shimmer.fromColors(
      child: Text("Shimmer Loading"),
      baseColor: Colors.red,
      highlightColor: Colors.grey[300]!);

  //実装なし
  Widget buildEffectImage(Food food) => Shimmer.fromColors(
      child: Image.network(food.urlImage),
      baseColor: Colors.blue,
      highlightColor: Colors.purple[200]!);
}
