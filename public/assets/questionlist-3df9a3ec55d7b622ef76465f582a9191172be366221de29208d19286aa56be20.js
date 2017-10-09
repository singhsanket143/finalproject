// bg_image_replace(".card-image a img", ".card-image a");
//
// function bg_image_replace(image, parent){
//     $(image).each(function(index,elem){
//
//         var src = $(elem).attr("src"),
//             $parent = $(elem).closest(parent);
//
//         $parent.css("background-image","url(" + src + ")");
//     });
// }
//
//
// /* Review */
// $( '.card-image' ).mouseover(function(){
//     $('#hov_<%= @question.id%>').fadeIn(100).toggleClass('active');
// }).mouseout(function(){
//     $('#hov_<%= @question.id%>').fadeOut(100).toggleClass('active');
// });
$('button').click(function(){
  if ($(this).children('i').text() === "favorite_border") {
    $(this).children('i').text('favorite');
  } else if ($(this).children('i').text() === "favorite") {
    $(this).children('i').text('favorite_border');
  }
});
