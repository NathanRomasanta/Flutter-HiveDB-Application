import 'package:cero/screens/bucket_1.dart';
import 'package:cero/screens/Settings.dart';
import 'package:flutter/material.dart';


class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}


class _MainNavigatorState extends State<MainNavigator> {



  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {


    // ignore: unused_local_variable
    int currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe4f23c),
        elevation: 0,
        actions: [IconButton(onPressed: (){

          var route = MaterialPageRoute(
        builder: (BuildContext context) => const Settings());
    Navigator.of(context).push(route);
        },
       icon: const Icon(Icons.menu, color: Colors.black,))]),


      body: PageView(
        controller: pageController,
        onPageChanged: (page) {
          currentIndex = page;


          setState(() {
            currentIndex = page;
          });
        },

        children: const <Widget> [
        
          Bucket1(),
          //Add new buckets here
       
        ],
      ),

      
    );
  }
}