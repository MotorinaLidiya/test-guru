// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import '../utilities/sorting'
import '../utilities/pagination'
import '../utilities/password-check'
import '../utilities/form_inline'
import '../utilities/locales'
import '../utilities/progress_bar'
import '../utilities/timer'

import $ from 'jquery'
import 'popper.js'
import 'bootstrap'

window.$ = window.jQuery = $

Rails.start()
Turbolinks.start()
ActiveStorage.start()
