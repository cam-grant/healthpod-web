!function(s){"use strict";function l(l){var a=s("#"+l);return a.length?a:(a=s('<ul id="'+l+'"><li class="osk-dragger osk-last-item">:&thinsp;:</li><li class="osk-symbol"><span class="osk-off">&acute;</span><span class="osk-on">#</span></li><li class="osk-number"><span class="osk-off">1</span><span class="osk-on">!</span></li><li class="osk-number"><span class="osk-off">2</span><span class="osk-on">&quot;</span></li><li class="osk-number"><span class="osk-off">3</span><span class="osk-on">&pound;</span></li><li class="osk-number"><span class="osk-off">4</span><span class="osk-on">$</span></li><li class="osk-number"><span class="osk-off">5</span><span class="osk-on">%</span></li><li class="osk-number"><span class="osk-off">6</span><span class="osk-on">^</span></li><li class="osk-number"><span class="osk-off">7</span><span class="osk-on">&amp;</span></li><li class="osk-number"><span class="osk-off">8</span><span class="osk-on">*</span></li><li class="osk-number"><span class="osk-off">9</span><span class="osk-on">(</span></li><li class="osk-number"><span class="osk-off">0</span><span class="osk-on">)</span></li><li class="osk-symbol"><span class="osk-off">-</span><span class="osk-on">_</span></li><li class="osk-symbol"><span class="osk-off">=</span><span class="osk-on">+</span></li><li class="osk-backspace osk-last-item">backspace</li><li class="osk-tab">tab</li><li class="osk-letter">q</li><li class="osk-letter">w</li><li class="osk-letter">e</li><li class="osk-letter">r</li><li class="osk-letter">t</li><li class="osk-letter">y</li><li class="osk-letter">u</li><li class="osk-letter">i</li><li class="osk-letter">o</li><li class="osk-letter">p</li><li class="osk-symbol"><span class="osk-off">[</span><span class="osk-on">{</span></li><li class="osk-symbol"><span class="osk-off">]</span><span class="osk-on">}</span></li><li class="osk-symbol osk-last-item"><span class="osk-off">\\</span><span class="osk-on">|</span></li><li class="osk-capslock">caps lock</li><li class="osk-letter">a</li><li class="osk-letter">s</li><li class="osk-letter">d</li><li class="osk-letter">f</li><li class="osk-letter">g</li><li class="osk-letter">h</li><li class="osk-letter">j</li><li class="osk-letter">k</li><li class="osk-letter">l</li><li class="osk-symbol"><span class="osk-off">;</span><span class="osk-on">:</span></li><li class="osk-symbol"><span class="osk-off">\'</span><span class="osk-on">@</span></li><li class="osk-return osk-last-item">return</li><li class="osk-shift">shift</li><li class="osk-letter">z</li><li class="osk-letter">x</li><li class="osk-letter">c</li><li class="osk-letter">v</li><li class="osk-letter">b</li><li class="osk-letter">n</li><li class="osk-letter">m</li><li class="osk-symbol"><span class="osk-off">,</span><span class="osk-on">&lt;</span></li><li class="osk-symbol"><span class="osk-off">.</span><span class="osk-on">&gt;</span></li><li class="osk-symbol"><span class="osk-off">/</span><span class="osk-on">?</span></li><li class="osk-hide osk-last-item">hide keyboard</li><li class="osk-space osk-last-item">space</li></ul>'),s("body").append(a),a)}s.fn.onScreenKeyboard=function(a){function o(l){var a=l.attr("data-osk-options");k.removeClass("osk-disabled"),n.removeClass("osk-focused"),void 0!==a&&(C=a.split(" "),s.inArray("disableSymbols",C)>-1&&p.addClass("osk-disabled"),s.inArray("disableTab",C)>-1&&b.addClass("osk-disabled"),s.inArray("disableReturn",C)>-1&&f.addClass("osk-disabled"),u.addClass("osk-disabled"),h.addClass("osk-disabled"))}function i(){var l,a=s(),o=c.width(),i=0;y&&k.each(function(){a=s(this),a.hasClass("osk-dragger")||a.hasClass("osk-space")||(i+=a.width()+Math.floor(parseFloat(a.css("marginRight"))/100*o),a.hasClass("osk-last-item")&&(l=o-i,l>0&&a.width(a.width()+l),l=0,i=0))})}var e=s.extend({draggable:!1,rewireReturn:!1,rewireTab:!1,topPosition:"20%",leftPosition:"30%"},a),n=this,t=s(),c=l("osk-container"),k=c.children("li"),r=c.children("li.osk-letter"),p=c.children("li.osk-symbol"),d=c.children("li.osk-number"),f=c.children("li.osk-return"),b=c.children("li.osk-tab"),u=c.children("li.osk-capslock"),h=c.children("li.osk-hide"),m=!1,g=!1,C=[],y=b.css("marginRight").indexOf("%")>-1;return e.draggable&&jQuery.ui&&(c.children("li.osk-dragger").show(),c.css("paddingTop","0").draggable({containment:"document",handle:"li.osk-dragger"})),e.rewireReturn&&f.html(e.rewireReturn),c.css("top",e.topPosition).css("left",e.leftPosition),i(),c.hide().css("visibility","visible"),s(window).resize(function(){i()}),n.click(function(){t=s(this),o(t),c.show()}),c.on("click","li",function(){var l,a,i=s(this),k=i.html();if(i.hasClass("osk-dragger")||i.hasClass("osk-disabled"))return t.focus(),!1;if(i.hasClass("osk-hide"))return c.fadeOut("fast"),t.blur(),n.removeClass("osk-focused"),!1;if(i.hasClass("osk-shift"))return r.toggleClass("osk-uppercase"),s.merge(p.children("span"),d.children("span")).toggle(),p.hasClass("osk-disabled")&&d.toggleClass("osk-disabled"),m=!m,g=!1,!1;if(i.hasClass("osk-capslock"))return r.toggleClass("osk-uppercase"),g=!0,!1;if(i.hasClass("osk-backspace"))return l=t.val(),t.val(l.substr(0,l.length-1)),t.trigger("keyup"),!1;if((i.hasClass("osk-symbol")||i.hasClass("osk-number"))&&(k=s("span:visible",i).html()),i.hasClass("osk-space")&&(k=" "),i.hasClass("osk-tab")){if(e.rewireTab)return t.trigger("onchange"),a=n.index(t)+1,t=s(a<n.length?n[a]:n[0]),o(t),!1;k="	"}if(i.hasClass("osk-return")){if(e.rewireReturn)return n.parent("form").submit(),!1;k="\n"}i.hasClass("osk-uppercase")&&(k=k.toUpperCase()),m&&(s.merge(p.children("span"),d.children("span")).toggle(),g||r.toggleClass("osk-uppercase"),e.disableSymbols&&d.toggleClass("osk-disabled"),m=!1),t.focus().val(t.val()+k),t.trigger("keyup")}),this}}(jQuery);