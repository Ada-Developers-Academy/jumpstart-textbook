$(document).ready(function(){
  //table of contents menu toggling
  $('.toc-menu,.toc-fade').on('click touchstart', function(e) {
    $('.toc,.toc-fade').toggleClass('is-visible');
    if( !$('.toc').hasClass('is-visible')) {
      $('.toc-content').prop({ scrollTop: 0 });
    }

    e.preventDefault();
  });

  //table of contents chapter list toggling
  $('.toc-chapter').on('click touchstart', function(e) {
    $(this)
      .toggleClass('is-current')
      .next('.toc-lectures').toggleClass('is-current');

    e.preventDefault();
  })

  //top nav menu toggle when in mobile layout
  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });
});
