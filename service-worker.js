const CACHE_NAME = 'hmonghymn-cache-v7';
const urlsToCache = [
  '/',    // Root index.html
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png',
'/index/contentalpha.html',
'/index/contentenglish.html',
'/index/contentnumeric.html',
'/index/contents.html',
'/index/h.html',
'/index/h1.html',
'/index/h10.html',
'/index/license.html',
'/index/urls_to_cache.txt',
'/index/css/slider.css',
'/index/css/style.css',
'/index/images/appname.png',
'/index/images/arrow-l-black.png',
'/index/images/arrow-r-black.png',
'/index/images/booktitle.png',
'/index/images/booktitle_old1.png',
'/index/images/booktitle_old2.png',
'/index/images/call.png',
'/index/images/CC.png',
'/index/images/footer_bg.png',
'/index/images/footer_bg1.png',
'/index/images/logo.png',
'/index/images/logo.psd',
'/index/images/music-notes.jpg',
'/index/images/pin.png',
'/index/images/search.png',
'/index/images/search_h.png',
'/index/images/slide-pagenat.png',
'/index/images/slider-icons.png',
'/index/images/slider_bg.jpg',
'/index/images/slider_bg1.jpg',
'/index/images/top-move.jpg',
'/index/js/easing.js',
'/index/js/jquery.cslider.js',
'/index/js/jquery.flexisel.js',
'/index/js/jquery.min.js',
'/index/js/modernizr.custom.28468.js',
'/index/js/move-top.js',
'/index/js/script.js'



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
        return response || caches.match('/index/contents.html');
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
            return caches.match('/index/contents.html');
          }
        })
      );
    })
  );
});