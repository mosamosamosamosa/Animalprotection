import 'package:anitection/components/animal_pad_background.dart';
import 'package:anitection/components/stroke_text.dart';
import 'package:anitection/components/triangle_line_painter.dart';
import 'package:anitection/components/triangle_painter.dart';
import 'package:anitection/layout/auth_guard_layout.dart';
import 'package:anitection/screens/animal_room/animal_room_screen.dart';
import 'package:anitection/screens/home/search_button.dart';
import 'package:anitection/screens/initial_animal_filter/initial_animal_type_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthGuardLayout(
        isLoggedIn: true,
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F2DB),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              color: const Color(0xFFC3EB89),
              child: SafeArea(
                child: Padding(
                  // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 24,
                          height: 18,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/ic_calendar.svg",
                            width: 38,
                            height: 38,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF94CD68),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 0),
                            child: const Text(
                              "10月30日",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/ic_setting.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              const AnimalPadBackground(),
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        size: Size(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.width * 0.10512820512 +
                                10),
                        painter: TrianglePainter(),
                      ),
                      Positioned(
                        child: CustomPaint(
                          size: Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.width *
                                  0.10512820512),
                          painter: TriangleLinePainter(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFB001),
                        width: 3,
                      ),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/img_empty_avatar.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: PointCounter(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    child: ListView.separated(
                        itemCount: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimalAvatarCard(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const AnimalRoomScreen(animalId: 1)));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 18,
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
          floatingActionButton: SearchButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const InitialAnimalTypeSelectionTypeScreen();
                  },
                ),
              );
            },
          ),
        ),
    );
  }
}

class PointCounter extends StatelessWidget {
  const PointCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/svg/ic_point.svg", width: 30, height: 30),
        const SizedBox(
          width: 4,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0x40077205),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: const Row(
            children: [
              Text("10,000",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900)),
              SizedBox(
                width: 4,
              ),
              Text("p",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900))
            ],
          ),
        )
      ],
    );
  }
}

class AnimalAvatarCard extends StatelessWidget {
  const AnimalAvatarCard({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Image.asset(
              "assets/images/img_example_cat_avatar.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StrokeText(
                  text: "あるるくん",
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF444444),
                  ),
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                    )
                  ],
                ),
                const Text(
                  "あにまる保護施設",
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
