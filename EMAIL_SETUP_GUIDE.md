# 이메일 전송 설정 가이드

## 🚀 빠른 설정 (5분 완료)

### 방법 1: Brevo 사용 (추천 - 무료, 간단)

1. **Brevo 계정 생성**
   - [Brevo](https://www.brevo.com/)에 가입 (무료)
   - 무료 플랜: 월 300통 이메일

2. **API 키 생성**
   - Brevo 대시보드 → Settings → API Keys
   - "Create a new API key" 클릭
   - API 키 복사

3. **코드 설정**
   `lib/services/email_service.dart` 파일에서:
   ```dart
   'api-key': 'YOUR_BREVO_API_KEY', // 여기에 복사한 API 키 입력
   ```

4. **발신자 이메일 설정**
   - Brevo 대시보드 → Senders & IP
   - 발신자 이메일 추가 (예: noreply@yourdomain.com)

### 방법 2: EmailJS 사용 (무료, 간단)

1. **EmailJS 계정 생성**
   - [EmailJS](https://www.emailjs.com/)에 가입
   - 무료 플랜: 월 200통 이메일

2. **이메일 서비스 설정**
   - EmailJS 대시보드 → Email Services
   - Gmail, Outlook 등 선택하여 연결

3. **이메일 템플릿 생성**
   - Email Templates → Create New Template
   - 아래 HTML 템플릿 사용:
   ```html
   <h2>Instagram 인증코드</h2>
   <p>안녕하세요!</p>
   <p>Instagram 로그인을 위한 인증코드입니다:</p>
   <h1 style="color: #0095F6; font-size: 32px; text-align: center; padding: 20px; background: #f8f9fa; border-radius: 8px;">{{verification_code}}</h1>
   <p>이 코드는 10분 후 만료됩니다.</p>
   <p>본인이 요청하지 않았다면 이 이메일을 무시하세요.</p>
   <br>
   <p>감사합니다,<br>Instagram 팀</p>
   ```

4. **코드 설정**
   `lib/services/email_service.dart` 파일에서:
   ```dart
   static const String serviceId = 'service_1234567'; // EmailJS 서비스 ID
   static const String templateId = 'template_1234567'; // EmailJS 템플릿 ID
   static const String userId = 'user_1234567'; // EmailJS 사용자 ID
   ```

## 현재 상태
현재 앱은 이메일 전송 시뮬레이션 모드로 작동하고 있습니다. 실제 이메일을 받으려면 위 방법 중 하나를 선택하여 설정하세요.

## 방법 1: EmailJS 사용 (무료, 추천)

### 1. EmailJS 계정 생성
1. [EmailJS](https://www.emailjs.com/)에 가입
2. 무료 플랜으로 시작 (월 200통 이메일)

### 2. 이메일 서비스 설정
1. EmailJS 대시보드에서 "Email Services" 클릭
2. "Add New Service" 클릭
3. Gmail, Outlook, 또는 다른 이메일 서비스 선택
4. 이메일 계정 정보 입력

### 3. 이메일 템플릿 생성
1. "Email Templates" 클릭
2. "Create New Template" 클릭
3. 아래 템플릿 사용:

```html
<h2>Instagram 인증코드</h2>
<p>안녕하세요!</p>
<p>Instagram 로그인을 위한 인증코드입니다:</p>
<h1 style="color: #0095F6; font-size: 32px; text-align: center; padding: 20px; background: #f8f9fa; border-radius: 8px;">{{verification_code}}</h1>
<p>이 코드는 10분 후 만료됩니다.</p>
<p>본인이 요청하지 않았다면 이 이메일을 무시하세요.</p>
<br>
<p>감사합니다,<br>Instagram 팀</p>
```

### 4. 코드 설정
`lib/services/email_service.dart` 파일에서 다음 값들을 업데이트:

```dart
static const String serviceId = 'YOUR_SERVICE_ID'; // EmailJS 서비스 ID
static const String templateId = 'YOUR_TEMPLATE_ID'; // EmailJS 템플릿 ID
static const String userId = 'YOUR_USER_ID'; // EmailJS 사용자 ID
```

## 방법 2: Supabase 이메일 서비스 사용

### 1. Supabase 대시보드 설정
1. Supabase 프로젝트 대시보드 접속
2. "Authentication" > "Settings" > "Email Templates"
3. 이메일 템플릿 커스터마이징

### 2. 이메일 제공업체 설정
1. "Authentication" > "Settings" > "SMTP Settings"
2. 이메일 제공업체 정보 입력 (Gmail, SendGrid 등)

## 방법 3: SendGrid 사용 (유료, 프로덕션용)

### 1. SendGrid 계정 생성
1. [SendGrid](https://sendgrid.com/)에 가입
2. API 키 생성

### 2. 코드 수정
`lib/services/email_service.dart`에 SendGrid API 호출 코드 추가:

```dart
static Future<bool> sendWithSendGrid(String email, String code) async {
  final response = await http.post(
    Uri.parse('https://api.sendgrid.com/v3/mail/send'),
    headers: {
      'Authorization': 'Bearer YOUR_SENDGRID_API_KEY',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'personalizations': [
        {
          'to': [{'email': email}],
          'subject': 'Instagram 인증코드',
        }
      ],
      'from': {'email': 'noreply@yourdomain.com'},
      'content': [
        {
          'type': 'text/html',
          'value': '<h1>인증코드: $code</h1>',
        }
      ],
    }),
  );
  
  return response.statusCode == 202;
}
```

## 테스트 방법

1. 앱 실행
2. 이메일 입력 후 "인증코드 전송" 버튼 클릭
3. 실제 이메일 수신 확인
4. 인증코드 입력하여 로그인 테스트

## 주의사항

- 무료 서비스는 월 사용량 제한이 있을 수 있습니다
- 프로덕션 환경에서는 유료 이메일 서비스 사용을 권장합니다
- 이메일 전송 실패 시 로그를 확인하여 문제 해결하세요

## 현재 개발 모드

현재는 이메일 전송 시뮬레이션 모드로 작동하며, 터미널에서 인증코드를 확인할 수 있습니다. 실제 이메일을 받으려면 위 설정 중 하나를 완료하세요.


