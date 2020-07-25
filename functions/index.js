const functions = require('firebase-functions');
const TorrentSearchApi = require('torrent-search-api');


TorrentSearchApi.enableProvider('1337x');
TorrentSearchApi.enableProvider('Rarbg');

exports.searchAll = functions.https.onCall((data, context) => {
    const search = data.search;
    return TorrentSearchApi.search(search).then((results) => {
        console.log(results);
        return results;
    });
})

exports.getMagnetLink = functions.https.onCall((data, context) => {
    const torrent = data.torrent;
    return TorrentSearchApi.getMagnet(torrent).then((magnet) => {
        console.log(magnet);
        return magnet;
    });
})