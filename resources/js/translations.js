//***** TRANSLATION *****//

Vue.prototype.trans = (string, params = {}) => {
    return window.trans(string, params)
}


window.trans = function(string, params = {}) {
    let str = _.get(window.i18n, string);
    if(!str) {
        return string
    }
    for (let key in params) {
        if (params.hasOwnProperty(key)) {
            str = str.replace(':'+key,params[key])
        }
    }
    return str;
}


Vue.prototype.transName = (object) => {
    let lang = window.lang
    if(typeof object === 'object') {
        return object[lang] ? object[lang] : (object['ru'] ? object['ru'] : '')
    }
    return object;
};