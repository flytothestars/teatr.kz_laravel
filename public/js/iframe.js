!function(e){var t={};function n(a){if(t[a])return t[a].exports;var r=t[a]={i:a,l:!1,exports:{}};return e[a].call(r.exports,r,r.exports,n),r.l=!0,r.exports}n.m=e,n.c=t,n.d=function(e,t,a){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:a})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var a=Object.create(null);if(n.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)n.d(a,r,function(t){return e[t]}.bind(null,r));return a},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p="/",n(n.s=3)}({3:function(e,t,n){e.exports=n("O1tm")},O1tm:function(e,t){var n,a,r;n=document.getElementsByTagName("head")[0],a=document.createElement("link"),r="https://teatr.kz/",a.type="text/css",a.rel="stylesheet",a.href=r+"css/iframe.css?2",n.appendChild(a),document.addEventListener("click",(function(e){if(e.target&&e.target.classList.contains("spaceduck-widget")){var t=e.target.dataset;!function(e,t,n,a){var i=arguments.length>4&&void 0!==arguments[4]?arguments[4]:"iframe",c=arguments.length>5?arguments[5]:void 0,o=arguments.length>6?arguments[6]:void 0,d=arguments.length>7?arguments[7]:void 0,l=arguments.length>8?arguments[8]:void 0,s=document.getElementsByTagName("body")[0],u=document.getElementsByClassName("spaceduck-iframe-wrap"),f="widget#/",m="?iframe=1";n&&n>0&&(m+="&hall_id="+n),a&&(m+="&lang="+a),c&&(m+="&fio="+c),o&&(m+="&phone="+o),d&&(m+="&email="+d),l&&(m+="&source="+l),i&&(m+="&additional_class="+i),e&&(f+=e+"/"),t&&(f+=t+"/"),u.length>0?u[0].style.display="block":s.insertAdjacentHTML("afterbegin",'<div class="spaceduck-iframe-wrap"><div class="spaceduck-iframe-container '+i+'"><div class="spaceduck-header"></div><a id="spaceduck-close" onclick="">&times;</a><div class="spaceduck-iframe-holder"><iframe src="'+r+f+m+'"></iframe><div class="spaceduck-close-frame"></div></div></div></div>'),document.getElementById("spaceduck-close").addEventListener("click",(function(){for(var e=document.getElementsByClassName("spaceduck-iframe-wrap");e.length>0;)e[0].parentNode.removeChild(e[0])}))}(t.eventId,t.timetableId,t.hallId,t.language,t.cl,t.fio,t.phone,t.email,t.source)}}))}});
//# sourceMappingURL=iframe.js.map