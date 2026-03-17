import "dart:convert";
import "package:http/http.dart" as http;
import "package:supabase_flutter/supabase_flutter.dart";

class EmailService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // Supabase OTP를 사용한 실제 이메일 전송
  static Future<bool> sendEmailWithSupabase(String email, String code) async {
    try {
      print("=== Supabase 이메일 전송 시도 ===");
      print("이메일: $email");
      print("인증코드: $code");
      
      final response = await _supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: null,
        data: {
          "verification_code": code,
        },
      );
      
      print("Supabase 응답: ${response.session != null ? '성공' : '실패'}");
      
      if (response.session != null) {
        print("✅ Supabase 이메일 전송 성공: $email");
        return true;
      }
      
      print("❌ Supabase 이메일 전송 실패");
      return false;
    } catch (e) {
      print("❌ Supabase 이메일 전송 오류: $e");
      return false;
    }
  }

  // EmailJS를 사용한 이메일 전송
  static Future<bool> sendVerificationEmail(String email, String code) async {
    try {
      print("=== EmailJS 이메일 전송 시도 ===");
      print("이메일: $email");
      print("인증코드: $code");
      
      const emailjsUrl = 'https://api.emailjs.com/api/v1.0/email/send';
      const serviceId = 'service_1234567';
      const templateId = 'template_1234567';
      const userId = 'user_1234567';
      
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

      print("EmailJS 응답: ${response.statusCode} - ${response.body}");
      
      if (response.statusCode == 200) {
        print("✅ EmailJS 이메일 전송 성공: $email");
        return true;
      } else {
        print("❌ EmailJS 이메일 전송 실패: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ EmailJS 이메일 전송 오류: $e");
      return false;
    }
  }

  // Brevo를 사용한 이메일 전송
  static Future<bool> sendWithFreeEmailService(String email, String code) async {
    try {
      print("=== Brevo 이메일 전송 시도 ===");
      print("이메일: $email");
      print("인증코드: $code");
      
      final response = await http.post(
        Uri.parse('https://api.brevo.com/v3/smtp/email'),
        headers: {
          'api-key': 'YOUR_BREVO_API_KEY',
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

      print("Brevo 응답: ${response.statusCode} - ${response.body}");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Brevo 이메일 전송 성공: $email");
        return true;
      } else {
        print("❌ Brevo 이메일 전송 실패: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Brevo 이메일 전송 오류: $e");
      return false;
    }
  }
}
