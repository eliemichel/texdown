/**
 * texdown - a custom markdown parser
 * Copyright (c) 2013-2013, Elie Michel. (MIT Licensed)
 *
 */

var express = require('express'),
    fs = require('fs'),
    texdown = require('./texdown');

express()


.get('/style.css', function (req, res) {
	fs.readFile('style.css', function (err, file) {
		res.end(file);
	});
})


.get('/:doc', function (req, res) {
	console.log('Request for ' + req.params.doc);
	fs.readFile(__dirname + '/sources/' + req.params.doc + '.td', 'utf8', function (err, source) {
		if (err) {
			res.end('Le document ' + req.params.doc + ' n\'a pas été créé.');
			return;
		}
		fs.readFile('texdown_start.html', 'utf8', function (err, start) {
			if (err) {
				res.end('An error occured : ' + err);
				return;
			}
			fs.readFile('texdown_end.html', 'utf8', function (err, end) {
				if (err) {
					res.end('An error occured : ' + err);
					return;
				}
				
				var body = texdown(source);
				res.end(start + body + end);
			});
		});
	});
})



.use('/public/', express.static(__dirname + '/public/'))

.listen(3615);

console.log('Serveur lancé');

