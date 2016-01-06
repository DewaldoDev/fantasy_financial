$(document).ready(function(){
    $('.stock-ticker').hover(function(){
        $(this).find('.stock-chart').fadeIn(500)
    },function(){
        $(this).find('.stock-chart').fadeOut(500)
    })
});