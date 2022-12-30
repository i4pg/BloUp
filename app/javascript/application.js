// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"
// import "./direct_upload.js"
// import "./navbar_toggle.js"
// import "./Upload_filename_detecet.js"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
