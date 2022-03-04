importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyDVMUtzjQx29o2lMKZx0IHSJ_5v_z4mqnk",
    authDomain: "eagle-tip.firebaseapp.com",
    databaseURL: "https://eagle-tip-default-rtdb.firebaseio.com",
    projectId: "eagle-tip",
    storageBucket: "eagle-tip.appspot.com",
    messagingSenderId: "168073462322",
    appId: "1:168073462322:web:b310a5d28dfd8b7aeeb22b",
    measurementId: "G-41HLGQ7ZHJ"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});