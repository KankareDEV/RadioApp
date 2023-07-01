import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:radio_project/models/music_data_response.dart';
import 'package:radio_project/screens/music_detail_page.dart';
import 'package:radio_project/services/api_service.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MusicDataResponse> musicList = [];

  @override
  void initState() {
    super.initState();
    fetchMusicData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.38),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset('lib/assets/images/logo.jpeg'),
        ),
        title: RichText(
          text: const TextSpan(
            text: 'Radio ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'Stream',
              ),
              TextSpan(
                text: ' Zone',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimationLimiter(
          child: GridView.builder(
            itemCount: musicList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.98,
            ),
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                duration: const Duration(milliseconds: 500),
                child: ScaleAnimation(
                  scale: 1.5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicDetailPage(
                            response: musicList[index],
                          ),
                        ),
                      );
                    },
                    child: AnimatedCard(
                      direction: AnimatedCardDirection.bottom,
                      initDelay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.black26,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: FadeInImage.assetNetwork(
                                placeholder: "lib/assets/images/no_image.jpeg",
                                image: musicList[index].image.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              bottom: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black87,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      musicList[index].title.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      musicList[index].artist.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> fetchMusicData() async {
    final musicListData = await ApiService().getAllFetchMusicData();
    setState(() {
      musicList = musicListData;
    });
  }
}
