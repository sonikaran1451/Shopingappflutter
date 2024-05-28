import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:taskapp4/Screen/Component/Card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _data = [];

  static const String url = 'https://dummyjson.com/products';

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['products'];
      setState(() {
        _data = json.decode(response.body)['products'];
        print(_data[0]['price']);
        _data.sort((a, b) => a['price'].compareTo(b['price']));
      });
      return data;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  late Future<List<dynamic>> _posts;

  @override
  void initState() {
    super.initState();
    print("aaa");
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllers = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 2;
    final desiredHeight = 237;
    final aspectRatio = itemWidth / desiredHeight;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //serchbar row
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 288,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(183, 204, 204, 204),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 15),
                      Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TextField(
                          // controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Search....',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.center_focus_weak_rounded,
                        size: 25,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 204, 204, 204),
                    borderRadius: BorderRadius.all(Radius.circular(46.0)),
                  ),
                  child: const Icon(
                    Icons.filter_list_rounded,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          //category
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          //customecard
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) => const CustomeCard()),
              ),
            ),
          ),
          //samsung Galexy Book text and icon
          ElevatedButton(
            onPressed: fetchPosts,
            child: Text('Fetch Posts'),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Samsung Galaxy Book",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Result",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 204, 204, 204),
                  borderRadius: BorderRadius.all(Radius.circular(46.0)),
                ),
                child: const Icon(
                  Icons.filter_list_rounded,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          //card
          Expanded(
              child: GridView.count(
            childAspectRatio: aspectRatio,
            crossAxisCount: 2,
            children: List.generate(
                _data.length,
                (index) => Gridcard(
                    producttitle: _data[index]['title'],
                    description: _data[index]['description'],
                    price: _data[index]['price'],
                     thumbnail: _data[index]['thumbnail'],
                    )),
          )),
        ],
      ),
    );
  }
}

class Gridcard extends StatelessWidget {
  final String producttitle;
  final String description;
  final double price;
  final String thumbnail;

  const Gridcard(
      {required this.producttitle,
      required this.description,
      required this.price,
       required this.thumbnail,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromARGB(101, 229, 231, 235),
            width: 2,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            thumbnail,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              producttitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              description,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 8, color: Colors.grey),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
             '$price\$' ,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
