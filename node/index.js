var express = require('express')
var app = express()
var Pusher = require('pusher');

var pusher = new Pusher({
    appId: '445303',
    key: '473c50678fde7578a7d7',
    secret: '3d6546954e79ead47c1f',
    cluster: 'ap1',
    encrypted: true
  });

app.get('/', function (req, res) {
  res.send('Hello Worsssssld!')
})

app.post('/send/basic', function (req, res) {
  pusher.trigger('my-channel', 'event0', {
    "message": "help"
  });
    res.send("hello")
})

app.post('/send/ok', function (req, res) {
  pusher.trigger('my-channel', 'event1', {
      "message": "ok"
    });
  res.send("ok")
})



app.listen(3000);
