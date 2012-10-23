$(document).ready(function(){

  jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - this.outerHeight()) / 2) +
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - this.outerWidth()) / 2) +
                                                $(window).scrollLeft()) + "px");
    return this;
  }

  /*

  $.cookie('the_cookie', 'the_value');

  Read Cookie

  $.cookie('the_cookie'); // => "the_value"
  $.cookie('not_existing'); // => null



  */

  if(!($.cookie('select_city'))){
    console.log('current');
    $("#city_container").center();
    $('#city_items li').click(function(){
      var city = $(this).text().replace(/\s+/g, '-').toLowerCase();
      console.log(city);
      $.cookie('select_city', city);
    });
  } else {
    // quick fix for now
    $("#overlay").remove();
    $("#city_container").remove();
  }
});
