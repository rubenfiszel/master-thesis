"use strict";
var page = require('webpage').create(),
    system = require('system'),
    address, output, size, pageWidth, pageHeight;

address = system.args[1];
output = system.args[2];
//    page.viewportSize = { width: 600, height: 600 };
page.open(address, function (status) {
    if (status !== 'success') {
        console.log('Unable to load the address!');
        phantom.exit(1);
    } else {
        window.setTimeout(function () {
	    var dim = page.evaluate(function() {
		return document.getElementsByTagName('svg')[0].style
	    });
	    page.paperSize = { width: dim.width, height: dim.height };	    
            page.render(output);
            phantom.exit();
        }, 200);
    }
});

