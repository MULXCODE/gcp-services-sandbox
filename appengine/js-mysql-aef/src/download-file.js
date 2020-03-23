function downloadFileFromUrl(url) {
    const http = require('http');
    const fs = require('fs');
    const file = fs.createWriteStream("output.zip");

    const request = http.get(url, function(response) {
      response.pipe(file);
    });
}

// kaggle datasets download -d sudalairajkumar/novel-corona-virus-2019-dataset
downloadFileFromUrl('http://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset/download')

module.exports = {
    downloadFileFromUrl
}