(function () {
    var head = document.getElementsByTagName('head')[0];

    var css = document.createElement('link');
    var host = 'https://teatr.kz/'
    css.type = 'text/css';
    css.rel = 'stylesheet';
    css.href = host+"css/iframe.css?2";
    head.appendChild(css);

    document.addEventListener('click',function(e){
        if(e.target && e.target.classList.contains('spaceduck-widget')) {
            var dataset = e.target.dataset;
            showWidget(dataset.eventId, dataset.timetableId, dataset.hallId, dataset.language, dataset.cl, dataset.fio, dataset.phone, dataset.email, dataset.source);
        }
    });

    document.addEventListener('click',function(e){
        if(e.target && e.target.classList.contains('spaceduck-widget-withoutpay')) {
            var dataset = e.target.dataset;
            showWidgetWithoutPay(dataset.eventId, dataset.timetableId, dataset.hallId, dataset.language, dataset.cl, dataset.fio, dataset.phone, dataset.email, dataset.source);
        }
    });

    function showWidgetWithoutPay(event_id, timetable_id, hall_id, language, additional_class = "iframe", fio, phone, email, source) {

        var body = document.getElementsByTagName('body')[0];
        var wrap = document.getElementsByClassName('spaceduck-iframe-wrap');
        var url_part = 'widget_without_pay#/';
        var get_params = '?iframe=1';
        if(hall_id && hall_id > 0) { get_params += '&hall_id='+hall_id; }
        if(language) { get_params += '&lang='+language; }
        if(fio) { get_params += '&fio='+fio; }
        if(phone) { get_params += '&phone='+phone; }
        if(email) { get_params += '&email='+email; }
        if(source) { get_params += '&source='+source; }
        if(additional_class) { get_params += '&additional_class='+additional_class; }
        if(event_id) {
            url_part += event_id+'/'
        }
        if(timetable_id) {
            url_part += timetable_id+'/';
        }

        if (wrap.length > 0) {
            wrap[0].style.display = 'block';
        } else {
            body.insertAdjacentHTML('afterbegin', '<div class="spaceduck-iframe-wrap">' +
                '<div class="spaceduck-iframe-container '+additional_class+'">' +
                '<div class="spaceduck-header"></div>' +
                '<a id="spaceduck-close" onclick="">&times;</a>' +
                '<div class="spaceduck-iframe-holder">' +
                '<iframe src="'+'http://127.0.0.1:8000/'+url_part+ get_params+'"></iframe>' +
                '<div class="spaceduck-close-frame"></div>' +
                '</div></div></div>');
        }

        document.getElementById('spaceduck-close').addEventListener("click", function () {
            var elements = document.getElementsByClassName('spaceduck-iframe-wrap');
            while (elements.length > 0) {
                elements[0].parentNode.removeChild(elements[0]);
            }
        });

    }

    function showWidget(event_id, timetable_id, hall_id, language, additional_class = "iframe", fio, phone, email, source) {

        var body = document.getElementsByTagName('body')[0];
        var wrap = document.getElementsByClassName('spaceduck-iframe-wrap');
        var url_part = 'widget#/';
        var get_params = '?iframe=1';
        if(hall_id && hall_id > 0) { get_params += '&hall_id='+hall_id; }
        if(language) { get_params += '&lang='+language; }
        if(fio) { get_params += '&fio='+fio; }
        if(phone) { get_params += '&phone='+phone; }
        if(email) { get_params += '&email='+email; }
        if(source) { get_params += '&source='+source; }
        if(additional_class) { get_params += '&additional_class='+additional_class; }
        if(event_id) {
            url_part += event_id+'/'
        }
        if(timetable_id) {
            url_part += timetable_id+'/';
        }

        if (wrap.length > 0) {
            wrap[0].style.display = 'block';
        } else {
            body.insertAdjacentHTML('afterbegin', '<div class="spaceduck-iframe-wrap">' +
                '<div class="spaceduck-iframe-container '+additional_class+'">' +
                '<div class="spaceduck-header"></div>' +
                '<a id="spaceduck-close" onclick="">&times;</a>' +
                '<div class="spaceduck-iframe-holder">' +
                '<iframe src="'+host+url_part+ get_params+'"></iframe>' +
                '<div class="spaceduck-close-frame"></div>' +
                '</div></div></div>');
        }

        document.getElementById('spaceduck-close').addEventListener("click", function () {
            var elements = document.getElementsByClassName('spaceduck-iframe-wrap');
            while (elements.length > 0) {
                elements[0].parentNode.removeChild(elements[0]);
            }
        });

    }
})();

