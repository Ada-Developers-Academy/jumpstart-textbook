$(document).ready(function(){
  //table of contents menu toggling
  $('.toc-menu,.toc-fade').on('click touchstart',function (e) {
    $('.toc,.toc-fade').toggleClass('is-visible');
    if( !$('.toc').hasClass('is-visible')) {
      $('.toc-content').prop({ scrollTop: 0 });
    }

    e.preventDefault();
  });
});
