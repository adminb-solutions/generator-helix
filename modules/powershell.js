/*eslint no-console: ["error", { allow: ["warn", "error", "log"] }] */
'use strict';

class Powershell {
	constructor() {
	}

	runAsync(pathToScriptFile, parameters,done) {
		const cmdline = pathToScriptFile;
		
		console.log('Powershell - running: ' + cmdline + ' ' + parameters);

		const PowerShell = require('powershell');
		let child = new PowerShell(cmdline + ' ' + parameters,{PSCore:true});

		child.on('output', function (data) {
			console.log(data);
		});

		child.on('error', function (data) {
			console.error('Error: ' + data);
		});

		child.on('end', function () {
			console.log('Powershell - done running ' + pathToScriptFile + parameters);
			done();
		});

	}
}

exports = module.exports = new Powershell();
