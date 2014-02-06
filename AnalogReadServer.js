var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app, { log: false })
  , fs = require('fs')
  , url = require("url")
  , path = require("path")
  , five = require("./libs/johnny-five/lib/johnny-five.js")
  , board
  , pinA0
  , analogData = new Object();

app.listen(8888);

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
 
var that = this;


  
 

for (var i = 0; i < 5; i++) {
     this.pinMode(i,five.Pin.ANALOG);
 }

  //this.loop(100, function() {
   
     this.analogRead(0, function(voltage) {
      analogData.A0 = voltage;
      });

     this.analogRead(1, function(voltage) {
      analogData.A1 = voltage;
      });

     this.analogRead(2, function(voltage) {
      analogData.A2 = voltage;
      });

     this.analogRead(3, function(voltage) {
      analogData.A3 = voltage;
      });

     this.analogRead(4, function(voltage) {
      analogData.A4 = voltage;
      });

     this.analogRead(5, function(voltage) {
      analogData.A5 = voltage;
      });
   
  
      
   // });


 
 




  io.sockets.on('connection', function (socket) {

    // socket.emit('analogRead', { hello: 'world' });
    
 
   that.loop(1, function() {
   //console.log(analogData);
   socket.emit('analogRead', { values: analogData});
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







// if(board.io !== null){
// board.on("ready", function() {

//   // Create a new `photoresistor` hardware instance.
//   pinA0 = new five.Sensor({
//     pin: "A0",
//     freq: 1
//   });

//   // Inject the `sensor` hardware into
//   // the Repl instance's context;
//   // allows direct command line access
//   board.repl.inject({
//     pot: pinA0
//   });

//   io.sockets.on('connection', function (socket) {


//     // socket.emit('analogRead', { hello: 'world' });
//     pinA0.on("data", function() {
//     //console.log(this.value);
//     socket.emit('analogRead', { A0: this.value});
//   });
  

// });

//   // "data" get the current reading from the photoresistor
  
// });
// }
