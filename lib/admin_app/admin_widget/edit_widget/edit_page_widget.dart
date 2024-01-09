import 'package:el_grocer/resources/resources.dart';
import 'package:flutter/material.dart';

class EditWidgetPage extends StatelessWidget {
  const EditWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Edit Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          children:  [
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(AppImages.person, width: 100, height: 100,),
                    ),
                    SizedBox(height: 20,),
                    const Column(
                      children: [
                        Text("Edit Users List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(AppImages.categories, height: 100, width: 100,),
                    ),
                    const SizedBox(height: 20,),
                    const Column(
                      children: [
                        Text("Edit Category List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(AppImages.products, height: 100, width: 100,),
                    ),
                    const SizedBox(height: 20,),
                    const Column(
                      children: [
                        Text("Edit Product List"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(AppImages.carousel, height: 100, width: 100,),
                    ),
                    SizedBox(height: 20,),
                    const Column(
                      children: [
                        Text("Edit Slider Page"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
