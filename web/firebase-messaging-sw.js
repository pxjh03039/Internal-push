// web/firebase-messaging-sw.js
importScripts('/firebase/firebase-app-compat.js');
importScripts('/firebase/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyCoJtpXhzrXPTgJQNBXjlgvEsj3IEhIppo",
  authDomain: "web.firebaseapp.com",
  projectId: "web-push-test-mhlee",
  messagingSenderId: "1007592869470",
  appId: "1:1007592869470:web:80aa9bc5316bd045992ecf",
});

const messaging = firebase.messaging();


messaging.onBackgroundMessage(function (payload) {
  console.log('[SW] Background Message received:', payload); // 수신된 전체 페이로드 확인
  if (!payload.notification) { // 현재 주석 처리된 상태
    const notificationTitle = payload.data['title'] || '📬 새 알림';
    const notificationOptions = {
      body: payload.data['body'] || '',
      icon: '/icon.png', // 테스트 URL
      data: payload.data,
    };
    console.log('[SW] Attempting to show notification with options:', JSON.stringify(notificationOptions)); // 알림 옵션 확인
    self.registration.showNotification(notificationTitle, notificationOptions)
      .then(() => console.log('[SW] Notification shown successfully.')) // 성공 로그
      .catch(error => console.error('[SW] Notification error:', error)); // 에러 로그 (중요!)
  }
});
self.addEventListener('notificationclick', function (event) {
  console.log('[SW] Notification click received.', event);
  event.notification.close();

  const clickedNotificationData = event.notification.data || {};

  // GoRouter가 사용할 경로 정보와 쿼리 파라미터를 구성합니다.
  const routePath = '/#/message'; // 이동할 경로
  const queryParams = clickedNotificationData; // 모든 데이터 그대로 쿼리 파라미터로 사용할 것임 (혹은 필요한 데이터만 추출)

  // URL을 미리 구성합니다. (새 창을 열거나, Flutter 앱이 URL을 파싱할 때 필요)
  let urlToOpen = `${self.location.origin}${routePath}`;
  const params = new URLSearchParams();
  console.log('메시지 확인');
  console.log(JSON.stringify(queryParams));
  for (const key in queryParams) {
    if (queryParams.hasOwnProperty(key)) {
      // 쿼리 파라미터 값은 항상 인코딩해야 합니다.
      params.append(key, encodeURIComponent(queryParams[key]));
    }
  }
  if (params.toString()) {
    urlToOpen += `?${params.toString()}`;
  }

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then(windowClients => {
      let clientToFocus = null;

      for (const client of windowClients) {
        // 기존 클라이언트를 찾고, 해당 클라이언트가 포커스 가능한지 확인
        // 앱의 시작 URL과 일치하는 클라이언트를 찾습니다.
        if (client.url.startsWith(self.location.origin) && 'focus' in client) {
          clientToFocus = client;
          break;
        }
      }

      if (clientToFocus) {
        console.log('[SW] Existing client found. Focusing and navigating:', clientToFocus.url, '->', urlToOpen);
        return clientToFocus.focus().then(focusedClient => {
          if (focusedClient.url !== urlToOpen) {
            return focusedClient.navigate(urlToOpen); // GoRouter 경로로 이동
          }
          return focusedClient;
        });
      } else {
        // 기존 클라이언트가 없으면 새 창을 엽니다.
        console.log('[SW] No existing client found. Opening new window:', urlToOpen);
        return clients.openWindow(urlToOpen);
      }
    })
  );
});