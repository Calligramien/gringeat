const initHeart = () => {
    $(".love").click(function(){
        $('.custom-heart').toggleClass('love');
        $('.line, .custom-heart').addClass("active").delay(300).queue(function(next){
          $('.line, .custom-heart').removeClass("active");
          next();
        });
      });
}
 export { initHeart };
