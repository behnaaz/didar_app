'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a3745777aa77fa5c7e7651dba08d36b8",
"assets/assets/fonts/Iran-sans/IRANSansMobile.ttf": "d41d82662a710e51ece8325e239c7711",
"assets/assets/fonts/Iran-sans/IRANSansMobile_Bold.ttf": "7129a6c333e3e7d35ae4f3856a0392ef",
"assets/assets/images/auth_bg_pattern.png": "0dad81cc3ed72caa8a6ca15208bf23e0",
"assets/assets/images/avatar-white.png": "f3218997cdbcd52731aa6f6f3457ed7f",
"assets/assets/images/d-icon-calendar.png": "492963839010f491f4de99a8a1c56d79",
"assets/assets/images/d-icon-pay.png": "cc0a275194dd98652a4772ee6500e163",
"assets/assets/images/d-icon-revenue.png": "77359f60c0a1953415af87409da09c91",
"assets/assets/images/d-icon-session-setting.png": "72f7c4e3881552bc88e6fab18f2fc229",
"assets/assets/images/d-icon-session.png": "aa74f379b6121d36e8768a6d3f6dea32",
"assets/assets/images/d-statistics-chart.png": "576f5398c041231c1f40d8161a2d868a",
"assets/assets/images/didar-coin-badge.png": "6c052121c99a8efe9265e1c8301aa4ea",
"assets/assets/images/Didar-Logo-Final-T.png": "eebb42ef1789b55c90ce57bc562246e9",
"assets/assets/images/edit.png": "099c50e25a84a47f8fe8f8d6c18cb225",
"assets/assets/images/email.png": "6b595ba487f76ebb9201507ac7ef4cef",
"assets/assets/images/empty-session-placeholder.png": "1ae91b132132a3b8bf8f286703a7cbd1",
"assets/assets/images/finger_point.png": "88aa9b384d24b8c0db731432cc42eb27",
"assets/assets/images/home-empty-session.png": "32040f43b2c18338cbcfef3df014a408",
"assets/assets/images/home-header.png": "393c55f3f433f714912deb9c47625ec1",
"assets/assets/images/rate-badge.png": "cbac14b781d1abba013f2ff14d81fc9d",
"assets/assets/images/student-badge.png": "4e893af3585f12be86d044d765c240c2",
"assets/assets/images/user.png": "da1ff86582c042b214385c91a0425936",
"assets/FontManifest.json": "a4b8743c1564346ad609a18541eaa557",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "8abc107876790bc702fa339d53049945",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "23621397bc1906a79180a918e98f35b2",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2873108c66cbcbc464e8b40613dfaf13",
"/": "2873108c66cbcbc464e8b40613dfaf13",
"main.dart.js": "5826d17fbfdd896480c07d3e7af59acb",
"manifest.json": "dfa5062124b60eb2b4bfaf831ae37f65",
"version.json": "88f7eb002936631435f40d5fccebc62d"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
