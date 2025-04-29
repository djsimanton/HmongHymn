const CACHE_NAME = 'hmonghymn-cache-v11';
const urlsToCache = [
  '/',    // Root index.html
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png',
'/contentalpha.html',
'/contentenglish.html',
'/contentnumeric.html',
'/contents.html',
'/h.html',
'/h1.html',
'/h10.html',
'/license.html',
'/urls_to_cache.txt',
'/css/slider.css',
'/css/style.css',
'/images/appname.png',
'/images/arrow-l-black.png',
'/images/arrow-r-black.png',
'/images/booktitle.png',
'/images/booktitle_old1.png',
'/images/booktitle_old2.png',
'/images/call.png',
'/images/CC.png',
'/images/footer_bg.png',
'/images/footer_bg1.png',
'/images/logo.png',
'/images/logo.psd',
'/images/music-notes.jpg',
'/images/pin.png',
'/images/search.png',
'/images/search_h.png',
'/images/slide-pagenat.png',
'/images/slider-icons.png',
'/images/slider_bg.jpg',
'/images/slider_bg1.jpg',
'/images/top-move.jpg',
'/js/easing.js',
'/js/jquery.cslider.js',
'/js/jquery.flexisel.js',
'/js/jquery.min.js',
'/js/modernizr.custom.28468.js',
'/js/move-top.js',
'/js/script.js'



  // Add more files as needed
];

// Install event: cache essential files
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(urlsToCache);
    })
  );
});

// Activate event: cleanup old caches if needed
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames =>
      Promise.all(
        cacheNames.map(cache => {
          if (cache !== CACHE_NAME) {
            return caches.delete(cache);
          }
        })
      )
    )
  );
});

// Fetch event: serve from cache, then fallback
self.addEventListener('fetch', event => {
  const request = event.request;
  const url = new URL(request.url);

  // Handle HTML navigation requests with .html fallback
  if (
    request.mode === 'navigate' ||
    (request.headers.get('accept')?.includes('text/html') && !url.pathname.endsWith('.html'))
  ) {
    const fallbackUrl = url.pathname.endsWith('/')
      ? `${url.pathname}index.html`
      : `${url.pathname}.html`;

    event.respondWith(
      caches.match(fallbackUrl).then(response => {
        return response || caches.match('/contents.html');
      })
    );
    return;
  }

  // Normal asset fetch
  event.respondWith(
    caches.match(request).then(response => {
      return (
        response ||
        fetch(request).catch(() => {
          // Fallback to contents.html if it's a navigation request
          if (request.mode === 'navigate') {
            return caches.match('/contents.html');
          }
        })
      );
    })
  );
});