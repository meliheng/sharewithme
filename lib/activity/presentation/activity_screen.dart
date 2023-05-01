import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/activity/application/activity_cubit/activity_cubit.dart';
import 'package:sharewithme/export.dart';

class ActivityScreen extends StatefulWidget {
  static const route = '/activity';
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildAddActivityButton(context),
      bottomNavigationBar: const NavigationBar(),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
              ActivityCard(
                content: "canım öyle istedi sana mı sorucam",
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildAddActivityButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.purple,
                      alignment: Alignment.center,
                      child: const Text(
                        "Yeni Paylaşım",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFieldWithIcon2(
                        hintText: "içerik",
                        icon: Icons.abc,
                        onChanged: (p0) {
                          context.read<ActivityCubit>().contentChanged(p0);
                        },
                      ),
                    ),
                    CustomButton(
                      title: "Paylaş",
                      color: Colors.purple,
                      onPressed: () {
                        context.read<ActivityCubit>().addActivity(context);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String content;

  const ActivityCard({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 100, maxHeight: 200),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text("Melo"),
                            ),
                            const Text("10:07"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(content),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.pink,
                            fill: 1,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.comment_outlined,
                            color: Colors.blue,
                            fill: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
