define(["chartjs"],function(e){e.pluginService.register({afterUpdate:function(t){if(t.config.options.elements.center){var r=e.helpers,n=t.config.options.elements.center,a=e.defaults.global,l=t.chart.ctx,f=r.getValueOrDefault(n.fontStyle,a.defaultFontStyle),o=r.getValueOrDefault(n.fontFamily,a.defaultFontFamily);if(n.fontSize)var i=n.fontSize;else{l.save();for(var i=r.getValueOrDefault(n.minFontSize,1),c=r.getValueOrDefault(n.maxFontSize,100),u=r.getValueOrDefault(n.maxText,n.text);;){l.font=r.fontString(i,f,o);if(!(l.measureText(u).width<2*t.innerRadius&&i<c)){i-=1;break}i+=1}l.restore()}t.center={font:r.fontString(i,f,o),fillStyle:r.getValueOrDefault(n.fontColor,a.defaultFontColor)}}},afterDraw:function(e){if(e.center){var t=e.config.options.elements.center,r=e.chart.ctx;r.save(),r.font=e.center.font,r.fillStyle=e.center.fillStyle,r.textAlign="center",r.textBaseline="middle";var n=(e.chartArea.left+e.chartArea.right)/2,a=(e.chartArea.top+e.chartArea.bottom)/2;r.fillText(t.text,n,a),r.restore()}}})});