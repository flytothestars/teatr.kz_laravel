//***** VUE FILTERS *****//

import moment from 'moment'
moment.locale(window.lang)

Vue.filter('formatDate', function(value, format = 'DD.MM.YYYY, HH:mm') {
    if (value) {
        return moment(String(value)).format(format)
    }
});

Vue.filter('formatTimetableDate', function(value, format = 'DD MMMM YYYY, в HH:mm') {
    if (value) {
        return moment(String(value)).format(format)
    }
});

var numeral = require("numeral");
numeral.localeData().delimiters.thousands = ' ';

Vue.filter("formatNumber", function (value) {
    return numeral(value).format("0,0"); // displaying other groupings/separators is possible, look at the docs
});

Vue.filter("short", function (value) {
    if (value.length > 30) {
        return value.substr(0, 27)+'...'
    }
    return value
});

Vue.filter("capitalize", function (value) {
    return value.charAt(0).toUpperCase() + value.slice(1);
});

Vue.filter("tableUrl", function (value, object) {
    if(value) {
        value = value.replace(/%\w+%/g, function(all) {
            return object[all.replace(/%/g,"")] || all;
        });
    }
    return value;
});

Vue.filter('strip_tags', function(value) {
    return value.replace(/<\/?[^>]+(>|$)/g, "");
});

Vue.filter('findById', function(arr, val) {
    let res = arr.filter(obj => {
        return obj.id == val
    })
    res = res[0]
    if(!res) {
        return ''
    }
    return (res.title ? res.title : res.title_ru)
});