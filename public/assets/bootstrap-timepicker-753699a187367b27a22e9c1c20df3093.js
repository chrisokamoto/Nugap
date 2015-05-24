!function(t){"use strict";var i=function(i,e){this.$element=t(i),this.options=t.extend({},t.fn.timepicker.defaults,e,this.$element.data()),this.minuteStep=this.options.minuteStep||this.minuteStep,this.secondStep=this.options.secondStep||this.secondStep,this.showMeridian=this.options.showMeridian||this.showMeridian,this.showSeconds=this.options.showSeconds||this.showSeconds,this.showInputs=this.options.showInputs||this.showInputs,this.disableFocus=this.options.disableFocus||this.disableFocus,this.template=this.options.template||this.template,this.modalBackdrop=this.options.modalBackdrop||this.modalBackdrop,this.defaultTime=this.options.defaultTime||this.defaultTime,this.open=!1,this.init()};i.prototype={constructor:i,init:function(){this.$element.parent().hasClass("input-append")?(this.$element.parent(".input-append").find(".add-on").on("click",t.proxy(this.showWidget,this)),this.$element.on({focus:t.proxy(this.highlightUnit,this),click:t.proxy(this.highlightUnit,this),keypress:t.proxy(this.elementKeypress,this),blur:t.proxy(this.blurElement,this)})):this.template?this.$element.on({focus:t.proxy(this.showWidget,this),click:t.proxy(this.showWidget,this),blur:t.proxy(this.blurElement,this)}):this.$element.on({focus:t.proxy(this.highlightUnit,this),click:t.proxy(this.highlightUnit,this),keypress:t.proxy(this.elementKeypress,this),blur:t.proxy(this.blurElement,this)}),this.$widget=t(this.getTemplate()).appendTo("body"),this.$widget.on("click",t.proxy(this.widgetClick,this)),this.showInputs&&this.$widget.find("input").on({click:function(){this.select()},keypress:t.proxy(this.widgetKeypress,this),change:t.proxy(this.updateFromWidgetInputs,this)}),this.setDefaultTime(this.defaultTime)},showWidget:function(i){if(i.stopPropagation(),i.preventDefault(),!this.open){this.$element.trigger("show"),this.disableFocus&&this.$element.blur();var e=t.extend({},this.$element.offset(),{height:this.$element[0].offsetHeight});this.updateFromElementVal(),t("html").trigger("click.timepicker.data-api").one("click.timepicker.data-api",t.proxy(this.hideWidget,this)),"modal"===this.template?this.$widget.modal("show").on("hidden",t.proxy(this.hideWidget,this)):(this.$widget.css({top:e.top+e.height,left:e.left}),this.open||this.$widget.addClass("open")),this.open=!0,this.$element.trigger("shown")}},hideWidget:function(){this.$element.trigger("hide"),"modal"===this.template?this.$widget.modal("hide"):this.$widget.removeClass("open"),this.open=!1,this.$element.trigger("hidden")},widgetClick:function(i){i.stopPropagation(),i.preventDefault();var e=t(i.target).closest("a").data("action");e&&(this[e](),this.update())},widgetKeypress:function(i){var e=t(i.target).closest("input").attr("name");switch(i.keyCode){case 9:this.showMeridian?"meridian"==e&&this.hideWidget():this.showSeconds?"second"==e&&this.hideWidget():"minute"==e&&this.hideWidget();break;case 27:this.hideWidget();break;case 38:switch(e){case"hour":this.incrementHour();break;case"minute":this.incrementMinute();break;case"second":this.incrementSecond();break;case"meridian":this.toggleMeridian()}this.update();break;case 40:switch(e){case"hour":this.decrementHour();break;case"minute":this.decrementMinute();break;case"second":this.decrementSecond();break;case"meridian":this.toggleMeridian()}this.update()}},elementKeypress:function(t){switch(this.$element.get(0),t.keyCode){case 0:break;case 9:this.updateFromElementVal(),this.showMeridian?"meridian"!=this.highlightedUnit&&(t.preventDefault(),this.highlightNextUnit()):this.showSeconds?"second"!=this.highlightedUnit&&(t.preventDefault(),this.highlightNextUnit()):"minute"!=this.highlightedUnit&&(t.preventDefault(),this.highlightNextUnit());break;case 27:this.updateFromElementVal();break;case 37:this.updateFromElementVal(),this.highlightPrevUnit();break;case 38:switch(this.highlightedUnit){case"hour":this.incrementHour();break;case"minute":this.incrementMinute();break;case"second":this.incrementSecond();break;case"meridian":this.toggleMeridian()}this.updateElement();break;case 39:this.updateFromElementVal(),this.highlightNextUnit();break;case 40:switch(this.highlightedUnit){case"hour":this.decrementHour();break;case"minute":this.decrementMinute();break;case"second":this.decrementSecond();break;case"meridian":this.toggleMeridian()}this.updateElement()}0!==t.keyCode&&8!==t.keyCode&&9!==t.keyCode&&46!==t.keyCode&&t.preventDefault()},setValues:function(t){if(this.showMeridian){var i=t.split(" "),e=i[0].split(":");this.meridian=i[1]}else var e=t.split(":");this.hour=parseInt(e[0],10),this.minute=parseInt(e[1],10),this.second=parseInt(e[2],10),isNaN(this.hour)&&(this.hour=0),isNaN(this.minute)&&(this.minute=0),this.showMeridian?(this.hour>12?this.hour=12:this.hour<1&&(this.hour=1),"am"==this.meridian||"a"==this.meridian?this.meridian="AM":("pm"==this.meridian||"p"==this.meridian)&&(this.meridian="PM"),"AM"!=this.meridian&&"PM"!=this.meridian&&(this.meridian="AM")):this.hour>=24?this.hour=23:this.hour<0&&(this.hour=0),this.minute<0?this.minute=0:this.minute>=60&&(this.minute=59),this.showSeconds&&(isNaN(this.second)?this.second=0:this.second<0?this.second=0:this.second>=60&&(this.second=59)),""!=this.$element.val()&&this.updateElement(),this.updateWidget()},setMeridian:function(t){"a"==t||"am"==t||"AM"==t?this.meridian="AM":"p"==t||"pm"==t||"PM"==t?this.meridian="PM":this.updateWidget(),this.updateElement()},setDefaultTime:function(t){if(t){if("current"===t){var i=new Date,e=i.getHours(),s=Math.floor(i.getMinutes()/this.minuteStep)*this.minuteStep,h=Math.floor(i.getSeconds()/this.secondStep)*this.secondStep,n="AM";this.showMeridian&&(0===e?e=12:e>=12?(e>12&&(e-=12),n="PM"):n="AM"),this.hour=e,this.minute=s,this.second=h,this.meridian=n}else"value"===t?this.setValues(this.$element.val()):this.setValues(t);""!=this.$element.val()&&this.updateElement(),this.updateWidget()}else this.hour=0,this.minute=0,this.second=0},formatTime:function(t,i,e,s){return t=10>t?"0"+t:t,i=10>i?"0"+i:i,e=10>e?"0"+e:e,t+":"+i+(this.showSeconds?":"+e:"")+(this.showMeridian?" "+s:"")},getTime:function(){return this.formatTime(this.hour,this.minute,this.second,this.meridian)},setTime:function(t){this.setValues(t),this.update()},update:function(){this.updateElement(),this.updateWidget()},blurElement:function(){this.highlightedUnit=void 0,this.updateFromElementVal()},updateElement:function(){var t=this.getTime();switch(this.$element.val(t).change(),this.highlightedUnit){case"hour":this.highlightHour();break;case"minute":this.highlightMinute();break;case"second":this.highlightSecond();break;case"meridian":this.highlightMeridian()}},updateWidget:function(){this.showInputs?(this.$widget.find("input.bootstrap-timepicker-hour").val(this.hour<10?"0"+this.hour:this.hour),this.$widget.find("input.bootstrap-timepicker-minute").val(this.minute<10?"0"+this.minute:this.minute),this.showSeconds&&this.$widget.find("input.bootstrap-timepicker-second").val(this.second<10?"0"+this.second:this.second),this.showMeridian&&this.$widget.find("input.bootstrap-timepicker-meridian").val(this.meridian)):(this.$widget.find("span.bootstrap-timepicker-hour").text(this.hour),this.$widget.find("span.bootstrap-timepicker-minute").text(this.minute<10?"0"+this.minute:this.minute),this.showSeconds&&this.$widget.find("span.bootstrap-timepicker-second").text(this.second<10?"0"+this.second:this.second),this.showMeridian&&this.$widget.find("span.bootstrap-timepicker-meridian").text(this.meridian))},updateFromElementVal:function(){var t=this.$element.val();t&&(this.setValues(t),this.updateWidget())},updateFromWidgetInputs:function(){var i=t("input.bootstrap-timepicker-hour",this.$widget).val()+":"+t("input.bootstrap-timepicker-minute",this.$widget).val()+(this.showSeconds?":"+t("input.bootstrap-timepicker-second",this.$widget).val():"")+(this.showMeridian?" "+t("input.bootstrap-timepicker-meridian",this.$widget).val():"");this.setValues(i)},getCursorPosition:function(){var t=this.$element.get(0);if("selectionStart"in t)return t.selectionStart;if(document.selection){t.focus();var i=document.selection.createRange(),e=document.selection.createRange().text.length;return i.moveStart("character",-t.value.length),i.text.length-e}},highlightUnit:function(){this.$element.get(0),this.position=this.getCursorPosition(),this.position>=0&&this.position<=2?this.highlightHour():this.position>=3&&this.position<=5?this.highlightMinute():this.position>=6&&this.position<=8?this.showSeconds?this.highlightSecond():this.highlightMeridian():this.position>=9&&this.position<=11&&this.highlightMeridian()},highlightNextUnit:function(){switch(this.highlightedUnit){case"hour":this.highlightMinute();break;case"minute":this.showSeconds?this.highlightSecond():this.highlightMeridian();break;case"second":this.highlightMeridian();break;case"meridian":this.highlightHour()}},highlightPrevUnit:function(){switch(this.highlightedUnit){case"hour":this.highlightMeridian();break;case"minute":this.highlightHour();break;case"second":this.highlightMinute();break;case"meridian":this.showSeconds?this.highlightSecond():this.highlightMinute()}},highlightHour:function(){this.highlightedUnit="hour",this.$element.get(0).setSelectionRange(0,2)},highlightMinute:function(){this.highlightedUnit="minute",this.$element.get(0).setSelectionRange(3,5)},highlightSecond:function(){this.highlightedUnit="second",this.$element.get(0).setSelectionRange(6,8)},highlightMeridian:function(){this.highlightedUnit="meridian",this.showSeconds?this.$element.get(0).setSelectionRange(9,11):this.$element.get(0).setSelectionRange(6,8)},incrementHour:function(){if(this.showMeridian)if(11===this.hour)this.toggleMeridian();else if(12===this.hour)return this.hour=1;return 23===this.hour?this.hour=0:(this.hour=this.hour+1,void 0)},decrementHour:function(){if(this.showMeridian){if(1===this.hour)return this.hour=12;12===this.hour&&this.toggleMeridian()}return 0===this.hour?this.hour=23:(this.hour=this.hour-1,void 0)},incrementMinute:function(){var t=this.minute+this.minuteStep-this.minute%this.minuteStep;t>59?(this.incrementHour(),this.minute=t-60):this.minute=t},decrementMinute:function(){var t=this.minute-this.minuteStep;0>t?(this.decrementHour(),this.minute=t+60):this.minute=t},incrementSecond:function(){var t=this.second+this.secondStep-this.second%this.secondStep;t>59?(this.incrementMinute(),this.second=t-60):this.second=t},decrementSecond:function(){var t=this.second-this.secondStep;0>t?(this.decrementMinute(),this.second=t+60):this.second=t},toggleMeridian:function(){this.meridian="AM"===this.meridian?"PM":"AM",this.update()},getTemplate:function(){if(this.options.templates[this.options.template])return this.options.templates[this.options.template];if(this.showInputs)var t='<input type="text" name="hour" class="bootstrap-timepicker-hour" maxlength="2"/>',i='<input type="text" name="minute" class="bootstrap-timepicker-minute" maxlength="2"/>',e='<input type="text" name="second" class="bootstrap-timepicker-second" maxlength="2"/>',s='<input type="text" name="meridian" class="bootstrap-timepicker-meridian" maxlength="2"/>';else var t='<span class="bootstrap-timepicker-hour"></span>',i='<span class="bootstrap-timepicker-minute"></span>',e='<span class="bootstrap-timepicker-second"></span>',s='<span class="bootstrap-timepicker-meridian"></span>';var h,n='<table class="'+(this.showSeconds?"show-seconds":"")+" "+(this.showMeridian?"show-meridian":"")+'">'+"<tr>"+'<td><a href="#" data-action="incrementHour"><i class="icon-chevron-up"></i></a></td>'+'<td class="separator">&nbsp;</td>'+'<td><a href="#" data-action="incrementMinute"><i class="icon-chevron-up"></i></a></td>'+(this.showSeconds?'<td class="separator">&nbsp;</td><td><a href="#" data-action="incrementSecond"><i class="icon-chevron-up"></i></a></td>':"")+(this.showMeridian?'<td class="separator">&nbsp;</td><td class="meridian-column"><a href="#" data-action="toggleMeridian"><i class="icon-chevron-up"></i></a></td>':"")+"</tr>"+"<tr>"+"<td>"+t+"</td> "+'<td class="separator">:</td>'+"<td>"+i+"</td> "+(this.showSeconds?'<td class="separator">:</td><td>'+e+"</td>":"")+(this.showMeridian?'<td class="separator">&nbsp;</td><td>'+s+"</td>":"")+"</tr>"+"<tr>"+'<td><a href="#" data-action="decrementHour"><i class="icon-chevron-down"></i></a></td>'+'<td class="separator"></td>'+'<td><a href="#" data-action="decrementMinute"><i class="icon-chevron-down"></i></a></td>'+(this.showSeconds?'<td class="separator">&nbsp;</td><td><a href="#" data-action="decrementSecond"><i class="icon-chevron-down"></i></a></td>':"")+(this.showMeridian?'<td class="separator">&nbsp;</td><td><a href="#" data-action="toggleMeridian"><i class="icon-chevron-down"></i></a></td>':"")+"</tr>"+"</table>";switch(this.options.template){case"modal":h='<div class="bootstrap-timepicker modal hide fade in" style="top: 30%; margin-top: 0; width: 200px; margin-left: -100px;" data-backdrop="'+(this.modalBackdrop?"true":"false")+'">'+'<div class="modal-header">'+'<a href="#" class="close" data-dismiss="modal">×</a>'+"<h4>Pick a Time</h4>"+"</div>"+'<div class="modal-content">'+n+"</div>"+'<div class="modal-footer">'+'<a href="#" class="btn btn-primary" data-dismiss="modal">Ok</a>'+"</div>"+"</div>";break;case"dropdown":h='<div class="bootstrap-timepicker dropdown-menu">'+n+"</div>"}return h}},t.fn.timepicker=function(e){return this.each(function(){var s=t(this),h=s.data("timepicker"),n="object"==typeof e&&e;h||s.data("timepicker",h=new i(this,n)),"string"==typeof e&&h[e]()})},t.fn.timepicker.defaults={minuteStep:15,secondStep:15,disableFocus:!1,defaultTime:"current",showSeconds:!1,showInputs:!0,showMeridian:!0,template:"dropdown",modalBackdrop:!1,templates:{}},t.fn.timepicker.Constructor=i}(window.jQuery);