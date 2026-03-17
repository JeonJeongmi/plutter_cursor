import "dart:convert";
import "package:supabase_flutter/supabase_flutter.dart";

class EmailService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // Supabase OTP를 사용한 실제 이메일 전송 (AuthService에서 직접 호출하므로 사용하지 않음)
  static Future<bool> sendEmailWithSupabase(String email, String code) async {
    try {
      print("🚀 EmailService: Supabase 이메일 전송 시작");
      print("📧 이메일: $email");
      print("🔢 인증코드: $code");
      print("⏳ 이메일 전송 중...");
      
      // Supabase OTP를 사용하여 실제 이메일 전송
      await _supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: null,
        data: {
          "verification_code": code,
        },
      );
      
      // signInWithOtp가 void를 반환하므로 예외가 없으면 성공으로 간주
      print("✅ EmailService: Supabase 이메일 전송 성공!");
      print("📬 이메일이 성공적으로 전송되었습니다: $email");
      print("📱 이메일 수신함을 확인해주세요.");
      print("🔢 인증코드: $code");
      return true;
    } catch (e) {
      print("❌ EmailService: Supabase 이메일 전송 오류: $e");
      print("🔍 오류 상세: $e");
      print("📋 해결 방법:");
      print("   1. Supabase 프로젝트 설정 확인");
      print("   2. SMTP 설정 완료 여부 확인");
      print("   3. 발신자 이메일 인증 상태 확인");
      return false;
    }
  }

  // 다른 이메일 서비스는 사용하지 않음 (Supabase만 사용)
  static Future<bool> sendVerificationEmail(String email, String code) async {
    return await sendEmailWithSupabase(email, code);
  }

  static Future<bool> sendWithFreeEmailService(String email, String code) async {
    return await sendEmailWithSupabase(email, code);
  }
}
