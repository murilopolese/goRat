var express = require( 'express' );
var app = express();
var http = require( 'http' ).Server( app );
var io = require( 'socket.io' )( http );
var robot = require( 'robotjs' );

app.use( express.static( 'static' ) );

var prevPos = { x: 100, y: 100 };
robot.moveMouse( prevPos.x, prevPos.y );

io.on('connection', function( socket ){
  console.log( 'a user connected' );

	socket.on( 'disconnect', function() {
		console.log( 'a user disconnected' );
	});

	socket.on( 'mousemove', function( posX, posY ) {
		console.log( 'mousemove', posX, posY );
		robot.moveMouseSmooth( posX, posY );
	});

	socket.on( 'mousedown', function( button ) {
		console.log( 'mousedown', button );
		robot.mouseToggle( 'down', button );
	});

	socket.on( 'mouseup', function( button ) {
		console.log( 'mousedown', button );
		robot.mouseToggle( 'up', button );
	});

});

http.listen( 3000, function(){
  console.log('listening on *:3000');
});
