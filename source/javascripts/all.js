$(document).ready(function(){
  $('.toc-menu,.toc-fade').on('click touchstart',function (e) {
    $('.toc,.toc-fade').toggleClass('is-visible');
    e.preventDefault();
  });
});
