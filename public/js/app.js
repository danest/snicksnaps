$(document).ready(function(){

  jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - this.outerHeight()) / 20) +
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

  // $("#city_ul li").hover(function(){
  //   console.log('hover');
  //   $("#city_container").css('height', '750px');
  // }, function(){
  //   $("#city_container").css('height', '189px');
  // })

  function citySelector() {
    $("#overlay").toggle();
    $("#city_container").center().toggle();
    $('#city_items li').click(function(){
      var city = $(this).text().replace(/\s+/g, '-').toLowerCase();
      console.log(city);
      $.cookie('select_city', city, { expires: 365, path: '/' });
      window.location = '/'
    });
  };

  $(".city-header-selector p").html($.cookie('select_city'));


  if( !($.cookie('select_city')) ){
    citySelector();
  }

   $(".city-header-selector p").click(function(){
    citySelector();
   });

  console.log($.cookie('select_city'));


});