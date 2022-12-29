'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "960e92ca0eb35dd2a2630ebde0ddd5f4",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"manifest.json": "21005cd76b4c42df888fdf69d946a00b",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"assets/AssetManifest.json": "366d80ad04b9dd2b0a6027affee23df3",
"assets/shaders/ink_sparkle.frag": "28a404c6523bd094ee13ab7bd8e1534e",
"assets/FontManifest.json": "3bb47dcfab8ca21e7c6bf50d83f1887c",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/newbie/map/newbie_map.png": "e903b4d41fd70500256e133364cc451b",
"assets/assets/images/newbie/map/components/modern_office.png": "72497e956e9aaeb0336fa30427c427e9",
"assets/assets/images/newbie/map/components/winter-2.png": "3b31017a2f5e4f08b5c84615ecb90a2f",
"assets/assets/images/newbie/map/components/entities.png": "9af222724da4ca60d19e4ecc836e09c9",
"assets/assets/images/newbie/map/components/winter-1.png": "c054d7447b53359e994b816070bab789",
"assets/assets/images/newbie/sprite_sheets/george_sprite_sheet.png": "0e924894991eff39c550f8472e3c2d86",
"assets/assets/images/newbie/sprite_sheets/light_spritesheet.png": "86d7177296c80b6b1d8d14d63ad216ca",
"assets/assets/images/newbie/sprite_sheets/ballon_spritesheet.png": "17667fe4e828c6d42a5c7f861b2223de",
"assets/assets/images/newbie/sprite_sheets/purple_girl_spritesheet.png": "08793f97151e4d296feb6d90f7de9bff",
"assets/assets/images/newbie/sprite_sheets/traffit_light_spritesheet.png": "e0bd10c48c14e68a6de0281a9c370c39",
"assets/assets/images/newbie/sprite_sheets/tree_winter_spritesheet.png": "b7273553bdac9047238ccc41be682a70",
"assets/assets/images/newbie/sprite_sheets/garland_spritesheet.png": "e6a2a1279401295c9653086a933ef19c",
"assets/assets/images/newbie/sprite_sheets/blue_boy_spritesheet.png": "4ffa2b48a0e225ab7ed14990e286b9b4",
"assets/assets/images/newbie/sprite_sheets/401_spritesheet.png": "207f04f7f8268bd9599b9a451383f60b",
"assets/assets/images/newbie/sprite_sheets/boy_with_stick_spritesheet.png": "743af08add0bc4361244bcc5b283ab5c",
"assets/assets/images/newbie/sprite_sheets/door_spritesheet.png": "0c1219ec611820039143ff523d91221f",
"assets/assets/images/newbie/sprite_sheets/lantern_light_spritesheet.png": "e983db5789d413dca9fbafe9ae3b6b79",
"assets/assets/images/newbie/sprite_sheets/girl_school_spritesheet.png": "60c49322ed28d7e41e868c915b605149",
"assets/assets/images/newbie/sprite_sheets/orange_boy_spritesheet.png": "569546c38a186031776fbee4baed09a9",
"assets/assets/images/newbie/sprite_sheets/cpu_indicators_spritesheet.png": "903fab46fc22e8ce70f54c7f44e14425",
"assets/assets/images/newbie/sprite_sheets/girl_throw_snowball_spritesheet.png": "201fd19a1cb8589745dfa89df79e61c2",
"assets/assets/images/newbie/sprite_sheets/cat_sleeping_spritesheet.png": "0be0ff77d681fbc2bed9a1bbc400f850",
"assets/assets/images/newbie/sprite_sheets/kid_yellow_spritesheet.png": "f943f90bceb1f98b28cfd4dca090da10",
"assets/assets/images/newbie/sprite_sheets/girl_pink_spritesheet.png": "6fe39aa10721a5a2af453319e33b008e",
"assets/assets/images/newbie/sprite_sheets/santa_claus_spritesheet.png": "814b53e4d93d7d5a16a3c6e55af6471e",
"assets/assets/images/newbie/sprite_sheets/girl_lilac_spritesheet.png": "c16d3c8d871ce44c8747d367dbe7beb8",
"assets/assets/images/newbie/sprite_sheets/brown_boy_spritesheet.png": "3febab9de44054d526d9e66cf8ff8b2e",
"assets/assets/images/newbie/sprite_sheets/bird_spritesheet.png": "da7dbcf7980b002afb9fad7a6ba1f560",
"assets/assets/images/newbie/sprite_sheets/figure_skates_girl.png": "fdfd53e4e6730057b6bee8dfeff73c26",
"assets/assets/images/newbie/sprite_sheets/fireplace_spritesheet.png": "6cdffc9fd380895b3291df733f5b956c",
"assets/assets/images/newbie/sprite_sheets/old_man_spritesheet.png": "33f248192cc2476d683136ea9ad8da70",
"assets/assets/images/newbie/sprite_sheets/tree_spritesheet.png": "8d3b9441ed6ea2c98470dcd691e4744b",
"assets/assets/images/newbie/sprite_sheets/rabbit_spritesheet.png": "05972573636e43992de6aa4f77178327",
"assets/assets/images/newbie/sprite_sheets/girl_glaucous_spritesheet.png": "2b54edec159fbcf18bb524eada34e37c",
"assets/assets/images/newbie/sprite_sheets/police_spritesheet.png": "266aa1aae74b7a77ffa05af9a7d72cbb",
"assets/assets/images/newbie/sprite_sheets/green_girl_spritesheet.png": "71a62fb7a9e1ae712e348174d3c75ba6",
"assets/assets/images/newbie/sprite_sheets/ambulance_spritesheet.png": "5f7c0793d1e2a7ca0d78cab8856eb680",
"assets/assets/images/newbie/sprites/info_sprite.png": "9d223cf52b3f9a5a77b086e88da3aced",
"assets/assets/images/newbie/sprites/java_image.png": "685e847208700f905ad788542a603a3c",
"assets/assets/images/newbie/sprites/buttons/button_grey_blank.png": "e65ddff024cf31cae0295895f4e49964",
"assets/assets/images/newbie/sprites/buttons/button_green_blank.png": "e2be5ebab8787588c434cd2509242ba0",
"assets/assets/images/newbie/sprites/coca_cola.png": "482fb9c08c3a7002518fa43f46394172",
"assets/assets/images/newbie/sprites/snowflake.png": "ba162dd6b46df850949290d30a5a4201",
"assets/assets/images/components/joystick_buttons/left.png": "4d10bcf4775127404b77254b6eb08f6c",
"assets/assets/images/components/joystick_buttons/up.png": "79187e5b12907c8b47e3b707162af4ef",
"assets/assets/images/components/joystick_buttons/down.png": "541283da3166be49ab672ffb4d014a7d",
"assets/assets/images/components/joystick_buttons/right.png": "5c0edd38dcd7b6da7192d871ab96b5b3",
"assets/assets/tiles/newbie_map.tmx": "00752cb2471ebb584776a424a3a038a2",
"assets/assets/fonts/vt323/VT323-Regular.ttf": "034de38c65e202c1cc838e7d014385fd",
"assets/assets/audio/betterdays.mp3": "b1ed81a9805aeec1678aac4a5a72bb2a",
"assets/assets/audio/inspiring-cinematic-ambient-116199.mp3": "1de574e5cdd0f8d654e6b3bd28968874",
"assets/assets/audio/click2.mp3": "3fb7f1e7bb6967dfd95a80ae19e626a2",
"assets/NOTICES": "eedbafaefbb67997220f62f5c698c9c2",
"index.html": "10862be38a59d20608c94cb15743863d",
"/": "10862be38a59d20608c94cb15743863d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "e51b47d8feb5b57135ab04379b7435ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
