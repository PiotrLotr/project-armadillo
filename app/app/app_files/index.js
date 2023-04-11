const express = require("express");
const app = express();
const fs = require("fs");
const mongodb = require('mongodb');

const MONGO_INITDB_ROOT_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME;
const MONGO_INITDB_ROOT_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD;
const MONGO_INITDB_DATABASE = process.env.MONGO_INITDB_DATABASE;

const url = `mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@db-service.local:27017`

app.get("/", function (req, res) {
  res.sendFile(__dirname + "/index.html");
});

app.get("/healthcheck", function (req, res) {
  res.status(200).send("Healthy...");
});

app.get('/init-video', function (req, res) {
  mongodb.MongoClient.connect(url, { useUnifiedTopology: true }, function (error, client) {
    if (error) {
      res.json(error);
      return;
    }
    const db = client.db(MONGO_INITDB_DATABASE);
    const bucket = new mongodb.GridFSBucket(db);
    const videoUploadStream = bucket.openUploadStream('bigbuck');
    const videoReadStream = fs.createReadStream('./bigbuck.mp4');
    videoReadStream.pipe(videoUploadStream);
    res.status(200).send("Done...");
  });
});

app.get("/mongo-video", function (req, res) {
  mongodb.MongoClient.connect(url, function (error, client) {
    if (error) {
      res.status(500).json(error);
      return;
    }

    const range = req.headers.range;
    if (!range) {
      res.status(400).send("Requires Range header");
    }

    const db = client.db(MONGO_INITDB_DATABASE);
    // GridFS Collection
    db.collection('fs.files').findOne({}, (err, video) => {
      if (!video) {
        res.status(404).send("No video uploaded!");
        return;
      }

      // Create response headers
      const videoSize = video.length;
      const start = Number(range.replace(/\D/g, ""));
      const end = videoSize - 1;

      const contentLength = end - start + 1;
      const headers = {
        "Content-Range": `bytes ${start}-${end}/${videoSize}`,
        "Accept-Ranges": "bytes",
        "Content-Length": contentLength,
        "Content-Type": "video/mp4",
      };

      // HTTP Status 206 for Partial Content
      res.writeHead(206, headers);

      const bucket = new mongodb.GridFSBucket(db);
      const downloadStream = bucket.openDownloadStreamByName('bigbuck', {
        start
      });

      // Finally pipe video to response
      downloadStream.pipe(res);
    });
  });
});

app.listen(80, function () {
  console.log("Listening on port 80!");
});
