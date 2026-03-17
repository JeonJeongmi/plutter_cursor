import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'email_service.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // 이메일로 인증코드 전송 (Supabase OTP 사용)
  static Future<bool> sendVerificationCode(String email) async {
    try {
      print("🚀 AuthService: 이메일 인증코드 전송 시작");
      print("📧 이메일: $email");
      
      // Supabase OTP를 사용하여 이메일 전송
      await _supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: null,
      );
      
      print("✅ AuthService: Supabase OTP 전송 성공");
      print("📬 이메일이 전송되었습니다: $email");
      print("📱 이메일 수신함을 확인해주세요.");
      
      return true;
    } catch (e) {
      print("❌ AuthService: 이메일 전송 실패");
      print("🔍 오류 상세: $e");
      return false;
    }
  }

  // Supabase OTP 검증
  static Future<bool> verifyCode(String email, String code) async {
    try {
      print("🔍 AuthService: OTP 검증 시작");
      print("📧 이메일: $email");
      print("🔢 입력된 코드: $code");
      
      // Supabase OTP 검증
      final response = await _supabase.auth.verifyOTP(
        email: email,
        token: code,
        type: OtpType.email,
      );
      
      if (response.session != null) {
        print("✅ AuthService: OTP 검증 성공");
        print("👤 사용자 인증 완료: ${response.user?.email}");
        return true;
      } else {
        print("❌ AuthService: OTP 검증 실패 - 세션이 없음");
        return false;
      }
    } catch (e) {
      print("❌ AuthService: OTP 검증 오류");
      print("🔍 오류 상세: $e");
      return false;
    }
  }

  // 사용자 로그인 (인증 성공 후)
  static Future<AuthResponse?> signInWithEmail(String email) async {
    try {
      // 이미 OTP 검증이 완료되었으므로 현재 세션 반환
      final session = _supabase.auth.currentSession;
      if (session != null) {
        print("✅ AuthService: 사용자 로그인 성공");
        print("👤 로그인된 사용자: ${session.user.email}");
        return AuthResponse(session: session, user: session.user);
      } else {
        print("❌ AuthService: 세션이 없음");
        return null;
      }
    } catch (e) {
      print("❌ AuthService: 로그인 오류");
      print("🔍 오류 상세: $e");
      return null;
    }
  }
}
