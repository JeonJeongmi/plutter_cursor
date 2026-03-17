import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/post_card.dart';
import '../widgets/story_widget.dart';
import '../widgets/theme_switch.dart';
import 'settings_screen.dart';
import 'camera_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'asset/icon/Camera Icon.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!,
              BlendMode.srcIn
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CameraScreen(),
              ),
            );
          },
        ),
        title: SvgPicture.asset(
          'asset/icon/Instagram Logo.svg',
          height: 30,
          colorFilter: ColorFilter.mode(
            Theme.of(context).brightness == Brightness.dark 
              ? Colors.white 
              : Colors.black, 
            BlendMode.srcIn
          ),
        ),
        actions: [
          // IGTV 아이콘 (알림 뱃지 포함)
          Stack(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'asset/icon/IGTV.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn
                  ),
                ),
                onPressed: () {},
              ),
              // 알림 뱃지
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // 메신저 아이콘
          IconButton(
            icon: SvgPicture.asset(
              'asset/icon/Messanger.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stories
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return StoryWidget(
                  username: 'user$index',
                  imageUrl: 'https://picsum.photos/60/60?random=$index',
                );
              },
            ),
          ),
          // Posts
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return PostCard(
                  username: 'user$index',
                  userImage: 'https://picsum.photos/40/40?random=$index',
                  postImage: 'https://picsum.photos/400/400?random=${index + 10}',
                  likes: (index + 1) * 10,
                  caption: 'This is a sample caption for post $index',
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 4) { // 프로필 탭
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
} 