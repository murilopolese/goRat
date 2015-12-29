# goRat!

Expose keyboard and mouse control via websocket.

## On Server

```js
var app = require( 'express' )();
var http = require( 'http' ).Server( app );
var io = require( 'socket.io' )( http );
var robot = require( 'robotjs' );
io.on('connection', function( socket ){
	socket.on( 'mousemove', function( posX, posY ) {
		robot.moveMouseSmooth( posX, posY );
	});
});
http.listen( 3000, function(){
  console.log('listening on *:3000');
});
```

## On Client

```html
<script type="text/javascript" src="socket.io.js"></script>
<script>
var socket = io();
socket.emit( 'mousemove', 100, 100 );
</script>
```

## Example

Run `npm install` and `node app.js` on the root path of this repository and open the brower on `http://localhost:3000`.
