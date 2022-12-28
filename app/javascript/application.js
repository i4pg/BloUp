// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"
import "./direct_upload.js"
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
