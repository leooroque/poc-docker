var express = require('express');
var load = require('consign');

module.exports = function () {
      var application = express();

      load({ cwd: './' })
      .include('routes')
            .into(application);
     
      return application;
}