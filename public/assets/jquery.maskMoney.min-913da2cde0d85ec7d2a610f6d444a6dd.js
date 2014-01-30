!function(e){"use strict";e.browser||(e.browser={},e.browser.mozilla=/mozilla/.test(navigator.userAgent.toLowerCase())&&!/webkit/.test(navigator.userAgent.toLowerCase()),e.browser.webkit=/webkit/.test(navigator.userAgent.toLowerCase()),e.browser.opera=/opera/.test(navigator.userAgent.toLowerCase()),e.browser.msie=/msie/.test(navigator.userAgent.toLowerCase()));var t={destroy:function(){return e(this).unbind(".maskMoney"),e.browser.msie&&(this.onpaste=null),this},mask:function(t){return this.each(function(){var n,a=e(this);return"number"==typeof t&&(a.trigger("mask"),n=e(a.val().split(/\D/)).last()[0].length,t=t.toFixed(n),a.val(t)),a.trigger("mask")})},unmasked:function(){return this.map(function(){var t,n=e(this).val()||"0",a=-1!==n.indexOf("-");return e(n.split(/\D/).reverse()).each(function(e,n){return n?(t=n,!1):void 0}),n=n.replace(/\D/g,""),n=n.replace(new RegExp(t+"$"),"."+t),a&&(n="-"+n),parseFloat(n)})},init:function(t){return t=e.extend({prefix:"",suffix:"",affixesStay:!0,thousands:"",decimal:".",precision:2,allowZero:!1,allowNegative:!1},t),this.each(function(){function n(){var e,t,n,a,r,o=b.get(0),i=0,s=0;return"number"==typeof o.selectionStart&&"number"==typeof o.selectionEnd?(i=o.selectionStart,s=o.selectionEnd):(t=document.selection.createRange(),t&&t.parentElement()===o&&(a=o.value.length,e=o.value.replace(/\r\n/g,"\n"),n=o.createTextRange(),n.moveToBookmark(t.getBookmark()),r=o.createTextRange(),r.collapse(!1),n.compareEndPoints("StartToEnd",r)>-1?i=s=a:(i=-n.moveStart("character",-a),i+=e.slice(0,i).split("\n").length-1,n.compareEndPoints("EndToEnd",r)>-1?s=a:(s=-n.moveEnd("character",-a),s+=e.slice(0,s).split("\n").length-1)))),{start:i,end:s}}function a(){var e=!(b.val().length>=b.attr("maxlength")&&b.attr("maxlength")>=0),t=n(),a=t.start,r=t.end,o=t.start!==t.end&&b.val().substring(a,r).match(/\d/)?!0:!1,i="0"===b.val().substring(0,1);return e||o||i}function r(e){b.each(function(t,n){if(n.setSelectionRange)n.focus(),n.setSelectionRange(e,e);else if(n.createTextRange){var a=n.createTextRange();a.collapse(!0),a.moveEnd("character",e),a.moveStart("character",e),a.select()}})}function o(e){var n="";return e.indexOf("-")>-1&&(e=e.replace("-",""),n="-"),n+t.prefix+e+t.suffix}function i(e){var n,a,r,i=e.indexOf("-")>-1&&t.allowNegative?"-":"",s=e.replace(/[^0-9]/g,""),l=s.slice(0,s.length-t.precision);return l=l.replace(/^0*/g,""),l=l.replace(/\B(?=(\d{3})+(?!\d))/g,t.thousands),""===l&&(l="0"),n=i+l,t.precision>0&&(a=s.slice(s.length-t.precision),r=new Array(t.precision+1-a.length).join(0),n+=t.decimal+r+a),o(n)}function s(e){var t,n=b.val().length;b.val(i(b.val())),t=b.val().length,e-=n-t,r(e)}function l(){var e=b.val();b.val(i(e))}function c(){var e=b.val();return t.allowNegative?""!==e&&"-"===e.charAt(0)?e.replace("-",""):"-"+e:e}function u(e){e.preventDefault?e.preventDefault():e.returnValue=!1}function v(t){t=t||window.event;var r,o,i,l,v,g=t.which||t.charCode||t.keyCode;return void 0===g?!1:48>g||g>57?45===g?(b.val(c()),!1):43===g?(b.val(b.val().replace("-","")),!1):13===g||9===g?!0:!e.browser.mozilla||37!==g&&39!==g||0!==t.charCode?(u(t),!0):!0:a()?(u(t),r=String.fromCharCode(g),o=n(),i=o.start,l=o.end,v=b.val(),b.val(v.substring(0,i)+r+v.substring(l,v.length)),s(i+1),!1):!1}function g(e){e=e||window.event;var a,r,o,i,l,c=e.which||e.charCode||e.keyCode;return void 0===c?!1:(a=n(),r=a.start,o=a.end,8===c||46===c||63272===c?(u(e),i=b.val(),r===o&&(8===c?""===t.suffix?r-=1:(l=i.split("").reverse().join("").search(/\d/),r=i.length-l-1,o=r+1):o+=1),b.val(i.substring(0,r)+i.substring(o,i.length)),s(r),!1):9===c?!0:!0)}function f(){w=b.val(),l();var e,t=b.get(0);t.createTextRange&&(e=t.createTextRange(),e.collapse(!1),e.select())}function d(){setTimeout(function(){l()},0)}function p(){var e=parseFloat("0")/Math.pow(10,t.precision);return e.toFixed(t.precision).replace(new RegExp("\\.","g"),t.decimal)}function h(n){if(e.browser.msie&&v(n),""===b.val()||b.val()===o(p()))t.allowZero?t.affixesStay?b.val(o(p())):b.val(p()):b.val("");else if(!t.affixesStay){var a=b.val().replace(t.prefix,"").replace(t.suffix,"");b.val(a)}b.val()!==w&&b.change()}function m(){var e,t=b.get(0);t.setSelectionRange?(e=b.val().length,t.setSelectionRange(e,e)):b.val(b.val())}var w,b=e(this);t=e.extend(t,b.data()),b.unbind(".maskMoney"),b.bind("keypress.maskMoney",v),b.bind("keydown.maskMoney",g),b.bind("blur.maskMoney",h),b.bind("focus.maskMoney",f),b.bind("click.maskMoney",m),b.bind("cut.maskMoney",d),b.bind("paste.maskMoney",d),b.bind("mask.maskMoney",l)})}};e.fn.maskMoney=function(n){return t[n]?t[n].apply(this,Array.prototype.slice.call(arguments,1)):"object"!=typeof n&&n?(e.error("Method "+n+" does not exist on jQuery.maskMoney"),void 0):t.init.apply(this,arguments)}}(window.jQuery||window.Zepto);