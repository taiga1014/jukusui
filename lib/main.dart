import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    player.play(UrlSource('note1.wave'));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music App',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF212121, {
          50: Color(0xFF424242),
          100: Color(0xFF616161),
          200: Color(0xFF757575),
          300: Color(0xFF9E9E9E),
          400: Color(0xFFBDBDBD),
          500: Color(0xFFE0E0E0),
          600: Color(0xFFEEEEEE),
          700: Color(0xFFF5F5F5),
          800: Color(0xFFFAFAFA),
          900: Color(0xFFFFFFFF),
        }),
        scaffoldBackgroundColor: Color(0xFF2C2C54), // 薄暗い青色に変更
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TitlePage(),
        '/musicList': (context) => MusicListPage(),
      },
    );
  }
}

class Music {
  final String title;
  final String artist;
  final String duration;
  final String audioPath; // 音楽ファイルのパスを追加

  Music({
    required this.title,
    required this.artist,
    required this.duration,
    required this.audioPath,
  });
}

class TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('快眠BGM'),
        backgroundColor: Color(0xFF2C2C54),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('sleeping.jpg'), // 枕の画像ファイルをassetsフォルダに配置してください
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/musicList');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 24),
            ),
            child: Text('BGM一覧へ'),
          ),
        ),
      ),
    );
  }
}

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  final List<Music> musicList = [
    Music(
      title: '眠りの世界',
      artist: 'ミレラ',
      duration: '3:05',
      audioPath: 'assets/music/nemuri-no-sekai.mp3',
    ),
    Music(
      title: 'Pyramid Sleep',
      artist: 'Pyroxene Of The Heart',
      duration: '6:37',
      audioPath: 'assets/music/pyramid-sleep.mp3',
    ),
    Music(
      title: '夢への入口',
      artist: 'Brownie',
      duration: '1:17',
      audioPath: 'assets/music/yume-heno-iriguchi.mp3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer(); // audioPlayerの初期化をinitStateメソッドで行う
  }

  @override
  void dispose() {
    //audioPlayer.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BGM一覧'),
        backgroundColor: Color(0xFF2C2C54),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('yozora.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: musicList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color(0xFF3D3D71),
              child: ListTile(
                title: Text(
                  musicList[index].title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  musicList[index].artist,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                  color: Colors.white,
                  onPressed: () {
                    if (isPlaying) {
                      audioPlayer.stop();
                    } else {
                      audioPlayer.play(UrlSource(musicList[index].audioPath));
                    }
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                    //playMusic(musicList[index].audioPath);
                    final audio_player = AudioPlayer();
                    audio_player.play(UrlSource(musicList[index].audioPath));
                    print('Music is playing');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> playMusic(String audioPath) async {
    //await audioPlayer.play(AssetSource("music/nemuri-no-sekai.mp3"));
    //audioPlayer.audioCache.loadAll(["music/nemuri-no-sekai.mp3"]);
    final player = AudioPlayer();
    //player.play(UrlSource('assets/music/nemuri-no-sekai.mp3'));
    print('Music is playing');
  }
}
