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
  if (!payload.notification) { // notification 필드 없을 때만 띄움
    const notificationTitle = payload.data?.title || '📬 새 알림';
    const notificationOptions = {
      body: payload.data?.body || '',
      icon: '/icon.png',
    };
    self.registration.showNotification(notificationTitle, notificationOptions);
  }
});