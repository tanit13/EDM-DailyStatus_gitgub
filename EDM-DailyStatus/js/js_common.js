function cache_clear() {
    window.location.reload(true);
    // window.location.reload(); use this if you do not remove cache
}

function page_time_reload (time_reload) {
    setInterval(function () {
        cache_clear()
    }, time_reload);
}