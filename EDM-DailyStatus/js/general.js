$(document).ready(function()
{
	/*alert();*/
	$("a.mobile").click(function()
	{
		$(".sidebar").slideToggle('slow');
	});

	window.onresize = function(event) {
	    /*if($(window).width() > 768){
	    	$('.sidebar').show();
	    }*/
	    if ($(window).width() < 768) {
	        $('.sidebar').show();
	    }

	};
});

$(document).ready(function () {
    /*alert();*/
    $("a.mobile_close").click(function () {
        $(".sidebar").slideToggle('slow');
    });

    window.onresize = function (event) {
        if ($(window).width() > 768) {
            $('.sidebar').show();
        }
    };
});