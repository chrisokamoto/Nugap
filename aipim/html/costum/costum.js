$(document).ready(function(){
	$('a').click(function(){
		var titulo = $(this).html();
		if (titulo == "[índice]") {
			$('html, body').animate({
				scrollTop: 0
			}, 1000);
		} else {
			$('html, body').animate({
				scrollTop: $('h3').filter(':contains("'+titulo+'")').offset().top - 30
			}, 1000);
		}
	});
});
