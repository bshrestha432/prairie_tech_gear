// app/javascript/packs/application.js
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("jquery")
import "bootstrap"
import "../stylesheets/application"
import "@hotwierd/turbo-rails"

document.addEventListener("turbolinks:load", function() {
  $('[data-toggle="tooltip"]').tooltip()
})