import 'package:flutter/material.dart';

class TestScrennnns extends StatelessWidget {
  const TestScrennnns({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
            image: NetworkImage(
                'https://cdn.bama.ir/uploads//BamaImages/News/843c84f1-dd4e-4df7-8d9a-f3c40d4769fc/article_638110490725990518_thumb_960_542.jpg')),
      ),
    );
  }
}
