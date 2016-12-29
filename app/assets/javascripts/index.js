var Preloader = function (element) {
    var video =  document.getElementById(element),
        preloader = document.getElementById('preloader'),
        enter = document.getElementById('enter');
    var ua = detect.parse(navigator.userAgent);
    if ( ua.os.family === 'Android' ) {
        video.setAttribute( 'controls','controls' );
    }

    var api = {};
    api._removePreloader = function() {
        preloader.style.opacity = 0;
        enter.style.opacity = 1;
    };
    api.startCheckingLoading = function() {
        video.addEventListener('click',function(){
            video.play();
        },false);
        video.addEventListener( 'play', api._removePreloader() );
    };
    return api;
}

window.addEventListener('load', function() {
    var preloader = Preloader('video');
    preloader.startCheckingLoading();

});
