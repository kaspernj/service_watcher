// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  modal_setup({
    css: {
      "border": "3px solid #4e4e4e",
      "background-color": "#f6f6f6",
      "padding": "10px",
      "padding-top": "0px",
      "padding-bottom": "14px",
      "width": "700px",
      "height": "700px",
      "overflow": "auto"
    },
    css_header: {
      "font-size": "16px",
      "font-weight": "bold",
      "padding-bottom": "7px",
      "padding-top": "5px",
      "color": "#000000"
    }
  })
})
