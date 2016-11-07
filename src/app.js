(function () {
  'use strict';

  require('./Stylesheets');

  var Elm = require('./Main');
  Elm.Main.embed(document.getElementById('container'));
})();
