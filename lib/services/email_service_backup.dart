import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  // EmailJS 설정 (무료 이메일 서비스)
  // 실제 사용을 위해 아래 값들을 EmailJS에서 받은 값으로 변경하세요
  static const String emailjsUrl = 'https://api.emailjs.com/api/v1.0/email/send';
  static const String serviceId = 'service_1234567'; // EmailJS 서비스 ID
  static const String templateId = 'template_1234567'; // EmailJS 템플릿 ID
  static const String userId = 'user_1234567'; // EmailJS 사용자 ID

  // 실제 이메일 전송 (EmailJS 사용)
  static Future<bool> sendVerificationEmail(String email, String code) async {
    try {
      // EmailJS API 호출
      final response = await http.post(
        Uri.parse(emailjsUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': email,
            'verification_code': code,
            'message': 'Instagram 인증코드: $code',
          },
        }),
      );

      if (response.statusCode == 200) {
        print('이메일 전송 성공: $email');
        return true;
      } else {
        print('이메일 전송 실패: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('이메일 전송 오류: $e');
      return false;
    }
  }

  // 대체 방법: 무료 이메일 서비스 사용 (Brevo/Sendinblue)
  static Future<bool> sendWithFreeEmailService(String email, String code) async {
    try {
      // Brevo (구 Sendinblue) 무료 이메일 서비스 사용
      // 무료 플랜: 월 300통 이메일
      final response = await http.post(
        Uri.parse('https://api.brevo.com/v3/smtp/email'),
        headers: {
          'api-key': 'YOUR_BREVO_API_KEY', // Brevo에서 발급받은 API 키
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sender': {
            'name': 'Instagram',
            'email': 'noreply@yourdomain.com',
          },
          'to': [
            {
              'email': email,
              'name': 'User',
            }
          ],
          'subject': 'Instagram 인증코드',
          'htmlContent': '''
            <html>
              <body>
                <h2>Instagram 인증코드</h2>
                <p>안녕하세요!</p>
                <p>Instagram 로그인을 위한 인증코드입니다:</p>
                <h1 style="color: #0095F6; font-size: 32px; text-align: center; padding: 20px; background: #f8f9fa; border-radius: 8px;">$code</h1>
                <p>이 코드는 10분 후 만료됩니다.</p>
                <p>본인이 요청하지 않았다면 이 이메일을 무시하세요.</p>
                <br>
                <p>감사합니다,<br>Instagram 팀</p>
              </body>
            </html>
          ''',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('이메일 전송 성공: $email');
        return true;
      } else {
        print('이메일 전송 실패: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('이메일 전송 오류: $e');
      return false;
    }
  }

  // 대체 방법: Supabase의 내장 이메일 기능 사용
  static Future<bool> sendEmailWithSupabase(String email, String code) async {
    try {
      // Supabase의 이메일 기능을 사용하는 방법
      // 실제 구현에서는 Supabase의 이메일 설정이 필요합니다
      
      final emailContent = '''
Instagram 인증코드

안녕하세요!

Instagram 로그인을 위한 인증코드입니다:

$code

이 코드는 10분 후 만료됩니다.
본인이 요청하지 않았다면 이 이메일을 무시하세요.

감사합니다,
Instagram 팀
      ''';

      // 실제 이메일 전송 로직
      // Supabase의 이메일 서비스를 사용하거나
      // 외부 이메일 서비스 API를 호출합니다
      
      print('=== 이메일 전송 시뮬레이션 ===');
      print('받는 사람: $email');
      print('제목: Instagram 인증코드');
      print('내용: $emailContent');
      print('========================');
      
      return true;
    } catch (e) {
      print('이메일 전송 오류: $e');
      return false;
    }
  }
}


