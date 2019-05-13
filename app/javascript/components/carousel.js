$('#myCarousel').on('slide.bs.carousel', function (e) {
    var $e = $(e.relatedTarget);
    var idx = $e.index();
    var itemsPerSlide = 4;
    var totalItems = $('#myCarousel .carousel-item').length;

    if (idx >= totalItems-(itemsPerSlide-1)) {
        var it = itemsPerSlide - (totalItems - idx);
        for (var i=0; i<it; i++) {
            // append slides to end
            if (e.direction=="left") {
                $('#myCarousel .carousel-inner .carousel-item').eq(i).appendTo('#myCarousel .carousel-inner');
            }
            else {
                $('#myCarousel .carousel-inner .carousel-item').eq(0).appendTo('#myCarousel .carousel-inner');
            }
        }
    }
});
$('#myCarousel2').on('slide.bs.carousel', function (e) {
    var $e = $(e.relatedTarget);
    var idx = $e.index();
    var itemsPerSlide = 4;
    var totalItems = $('#myCarousel2 .carousel-item').length;

    if (idx >= totalItems-(itemsPerSlide-1)) {
        var it = itemsPerSlide - (totalItems - idx);
        for (var i=0; i<it; i++) {
            // append slides to end
            if (e.direction=="left") {
                $('#myCarousel2 .carousel-item').eq(i).appendTo('#myCarousel2 .carousel-inner');
            }
            else {
                $('#myCarousel2 .carousel-item').eq(0).appendTo('#myCarousel2 .carousel-inner');
            }
        }
    }
});
$('#myCarousel3').on('slide.bs.carousel', function (e) {
    var $e = $(e.relatedTarget);
    var idx = $e.index();
    var itemsPerSlide = 4;
    var totalItems = $('#myCarousel3 .carousel-item').length;

    if (idx >= totalItems-(itemsPerSlide-1)) {
        var it = itemsPerSlide - (totalItems - idx);
        for (var i=0; i<it; i++) {
            // append slides to end
            if (e.direction=="left") {
                $('#myCarousel3 .carousel-inner .carousel-item').eq(i).appendTo('#myCarousel3 .carousel-inner');
            }
            else {
                $('#myCarousel3 .carousel-inner .carousel-item').eq(0).appendTo('#myCarousel3 .carousel-inner');
            }
        }
    }
});
$('#myCarousel4').on('slide.bs.carousel', function (e) {
    var $e = $(e.relatedTarget);
    var idx = $e.index();
    var itemsPerSlide = 3;
    var totalItems = $('#myCarousel4 .carousel-item').length;

    if (idx >= totalItems-(itemsPerSlide-1)) {
        var it = itemsPerSlide - (totalItems - idx);
        for (var i=0; i<it; i++) {
            // append slides to end
            if (e.direction=="left") {
                $('#myCarousel4 .carousel-inner .carousel-item').eq(i).appendTo('#myCarousel4 .carousel-inner');
            }
            else {
                $('#myCarousel4 .carousel-inner .carousel-item').eq(0).appendTo('#myCarousel4 .carousel-inner');
            }
        }
    }
});


