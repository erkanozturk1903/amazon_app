import 'package:amazon_app/views/buyers/nav_screen/widgets/banner_widget.dart';
import 'package:amazon_app/views/buyers/nav_screen/widgets/search_input_widget.dart';
import 'package:amazon_app/views/buyers/nav_screen/widgets/welcome_text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WelcomeText(),
        const SizedBox(
          height: 14,
        ),
        SearchInput(),
        BannerWidget(),
      ],
    );
  }
}

