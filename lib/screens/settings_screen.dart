import 'package:flutter/material.dart';
import '../widgets/theme_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // 테마 설정
          ListTile(
            leading: Icon(Icons.palette),
            title: Text('테마'),
            subtitle: Text('라이트 / 다크 모드'),
            trailing: const ThemeSwitch(),
          ),
          
          const Divider(),
          
          // 게시물 추가
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            title: Text('새 게시물'),
            subtitle: Text('사진이나 동영상을 공유하세요'),
            onTap: () {
              // 게시물 추가 기능
            },
          ),
          
          // 좋아요
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('좋아요'),
            subtitle: Text('좋아요한 게시물을 확인하세요'),
            onTap: () {
              // 좋아요 목록 기능
            },
          ),
          
          // 메시지
          ListTile(
            leading: Icon(Icons.chat_bubble_outline),
            title: Text('메시지'),
            subtitle: Text('친구들과 대화하세요'),
            onTap: () {
              // 메시지 기능
            },
          ),
          
          const Divider(),
          
          // 계정 설정
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('계정'),
            subtitle: Text('프로필 및 개인정보 설정'),
            onTap: () {
              // 계정 설정 기능
            },
          ),
          
          // 개인정보 보호
          ListTile(
            leading: Icon(Icons.security),
            title: Text('개인정보 보호'),
            subtitle: Text('개인정보 및 보안 설정'),
            onTap: () {
              // 개인정보 보호 설정
            },
          ),
          
          // 알림 설정
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('알림'),
            subtitle: Text('알림 설정을 관리하세요'),
            onTap: () {
              // 알림 설정
            },
          ),
          
          const Divider(),
          
          // 도움말
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('도움말'),
            subtitle: Text('도움말 및 지원'),
            onTap: () {
              // 도움말 기능
            },
          ),
          
          // 정보
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('정보'),
            subtitle: Text('앱 정보 및 라이선스'),
            onTap: () {
              // 앱 정보
            },
          ),
        ],
      ),
    );
  }
}
