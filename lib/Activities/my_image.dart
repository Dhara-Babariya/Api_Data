import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              size: 40,
              color: Color(
                0xffdba84f,
              ),
            ),
            Image.network(
              'https://th.bing.com/th/id/OIG.CO2sHWK_IEYIwzXsC2hX',
              height: 300,
            ),
            Image.asset(
              'assets/image/images.jpg',
            ),
            InkWell(
              onTap: (){},
              child: Image.asset(
                'assets/icons/LunchBox.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
