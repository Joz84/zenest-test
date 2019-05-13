$(window).scroll(function(){

  var wintop = $(this).scrollTop();

  $('.position-img-birds-right').each(function(){
    if(wintop > $(this).offset().top - ($(window).height())){
      $(this).addClass('animate');
      $(this).removeClass('position-img-birds-right-start');
    }
  });
  $('.position-img-birds-left').each(function(){
    if(wintop > $(this).offset().top - ($(window).height())){
      $(this).addClass('animate');
      $(this).removeClass('position-img-birds-left-start');
    }
  });
  $('.position-img-birds-right2').each(function(){
    if(wintop > $(this).offset().top - ($(window).height())){
      $(this).addClass('animate');
      $(this).removeClass('position-img-birds-right-start');
    }
  });
});
