import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/sidebar/sider_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(),
        body: Builder(
          builder: (context) => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                  child: const Text(
                    "Clique Aqui Para Explorar 🖥️",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Image.network(
                  "https://www.neobyte.com.br/wp-content/uploads/2020/10/analytics.png.webp",
                ),
              ],
            ),
          ),
        ),
      );
}
