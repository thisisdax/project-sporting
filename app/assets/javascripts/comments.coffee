# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

click = ->
  $('#comments-link').click ->
    $('#comments-section').fadeToggle()
    $('#comment_message').focus()

# remove = ->
#   $('.deleteme').each ->
#     things = $(this)
#     things.click ->
#       alert "YAYYYYYY"


$(document).ready(click)
$(document).on('page:change', click)


# $(document).on('page:change', remove)
