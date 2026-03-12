/**
 * Ініціалізація головного Swiper на crane-ukraine.com
 * Додай цей код у Webflow: Site settings → Custom Code → Footer (перед </body>)
 * Переконайся, що Swiper CSS і JS підключені вище цього коду.
 */
(function() {
  function initMainSwiper() {
    if (typeof Swiper === 'undefined') return false;
    var container = document.querySelector('.swiper:not(.swiper-initialized)') ||
                   document.querySelector('.main-swiper') ||
                   document.querySelector('#main-swiper') ||
                   document.querySelector('[class*="swiper"]:not(.swiper-initialized)');
    if (!container) return false;
    new Swiper(container, {
      loop: true,
      speed: 600,
      autoplay: { delay: 5000, disableOnInteraction: false },
      pagination: container.querySelector('.swiper-pagination') ? { el: '.swiper-pagination', clickable: true } : false,
      navigation: container.querySelector('.swiper-button-next') ? {
        nextEl: container.querySelector('.swiper-button-next'),
        prevEl: container.querySelector('.swiper-button-prev')
      } : false,
      on: { init: function() { container.classList.add('swiper-initialized'); } }
    });
    return true;
  }
  function tryInit() {
    if (initMainSwiper()) return;
    setTimeout(tryInit, 100);
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() { setTimeout(tryInit, 50); });
  } else {
    setTimeout(tryInit, 50);
  }
})();
