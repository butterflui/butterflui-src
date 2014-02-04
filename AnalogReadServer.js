var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , url = require("url")
  , path = require("path")
  , five = require("./libs/johnny-five/lib/johnny-five.js")
  , board
  , photoresistor;

app.listen(8080);
board = new five.Board();


function handler (request, response) {

  var uri = url.parse(request.url).pathname
    , filename = path.join(process.cwd(), uri);

  path.exists(filename, function(exists) {
    if(!exists) {
      response.writeHead(404, {"Content-Type": "text/plain"});
      response.write("404 Not Found\n");
      response.end();
      return;
    }

    if (fs.statSync(filename).isDirectory()) filename += '/index.html';

    fs.readFile(filename, "binary", function(err, file) {
      if(err) {        
        response.writeHead(500, {"Content-Type": "text/plain"});
        response.write(err + "\n");
        response.end();
        return;
      }

      response.writeHead(200);
      response.write(file, "binary");
      response.end();
    });
  });
}








board.on("ready", function() {

  // Create a new `photoresistor` hardware instance.
  photoresistor = new five.Sensor({
    pin: "A0",
    freq: 1
  });

  // Inject the `sensor` hardware into
  // the Repl instance's context;
  // allows direct command line access
  board.repl.inject({
    pot: photoresistor
  });

  io.sockets.on('connection', function (socket) {


    // socket.emit('analogRead', { hello: 'world' });
    photoresistor.on("data", function() {
    //console.log(this.value);
    socket.emit('analogRead', { A0: this.value});
  });
  

});

  // "data" get the current reading from the photoresistor
  
});




console.log("Static file server running at\n  => http://localhost: 8080 /\nCTRL + C to shutdown");








//board = new five.Board();

// var five = require("./libs/johnny-five/lib/johnny-five.js"),
//   board, photoresistor;

// board.on("ready", function() {

//   // Create a new `photoresistor` hardware instance.
//   photoresistor = new five.Sensor({
//     pin: "A0",
//     freq: 250
//   });

//   // Inject the `sensor` hardware into
//   // the Repl instance's context;
//   // allows direct command line access
//   board.repl.inject({
//     pot: photoresistor
//   });

//   // "data" get the current reading from the photoresistor
//   photoresistor.on("data", function() {
//     analogData = this.value;
//     //socket.emit('AnalogRead', analogData);
//     //console.log(this.value);
//   });
// });


// // References
// //
// // http://nakkaya.com/2009/10/29/connecting-a-photoresistor-to-an-arduino/
