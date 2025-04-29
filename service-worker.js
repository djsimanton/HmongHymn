const CACHE_NAME = 'hmonghymn-cache-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/css/mobile.css',
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png',
'/index/contentalpha.html',
'/index/contentenglish.html',
'/index/contentnumeric.html',
'/index/contents.html',
'/index/h.html',
'/index/h1.html',
'/index/h10.html'



  // Add more files as needed
];



// Install event
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(urlsToCache))
  );
  self.skipWaiting();
});

// Activate event
self.addEventListener('activate', event => {
  event.waitUntil(clients.claim());
});

// Updated fetch event with fallback
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request).catch(() => {
        // Fallback for navigation requests (when offline)
        if (event.request.mode === 'navigate') {
          return caches.match('/index/contents.html');
        }
      });
    })
  );
});