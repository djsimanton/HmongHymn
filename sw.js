const CACHE_NAME = 'hmonghymn-cache-v1';
const urlsToCache = [
  '/',
  '/index/index.html',
  '/css/mobile.css',
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png'
  // Add more files as needed
];

// Install event
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(urlsToCache))
  );
});

// Fetch event
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => response || fetch(event.request))
  );
});
