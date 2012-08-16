# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	thumbnailCss =
		top: (190 - $(".thumbnail img").height()) / 2
	$(".thumbnail img").load -> css(thumbnailCss)
	$(".thumbnail").click ->
		if $(@).find("input[type=hidden]").val() is "false"
			$(@).addClass("selected")
			$(@).find("input[type=hidden]").val("true")
		else
			$(@).removeClass("selected")
			$(@).find("input[type=hidden]").val("false")
	setTimeout ( ->
		if $('.pagination')?
			$(window).scroll ->
				url = $('.pagination .next_page').attr('href')
				if  url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
					$('.pagination').html("<div id='page-load'><img src='/assets/ajax-loader.gif' /></div>")
					$.getScript(url)
			$(window).scroll()
	), 0.01
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()
	$('form').on 'click', '.remove_fields', (event) ->
		$(@).prev('input[type=hidden]').val('1')
		$(@).closest('div').hide()
		event.preventDefault()
	$('a.year-link').toggle (event) ->
		$(@).parent().find("ul.months").slideDown("fast")
		event.preventDefault()
	, ->
		$(@).parent().find("ul.months").slideUp("fast")
		event.preventDefault()
	$(document).on "click", "#close", (event) ->
		$("html").css({"overflow":"visible"})
		$("body").css({"overflow":"visible"})
		$(@).parent().parent().find("#visuals").fadeOut "fast", ->
			$(@).remove()
		$(@).parent().parent().find("#blackout").fadeOut "fast", ->
			$(@).remove()
	$("#stories").on "click", ".twitter-share, .facebook-share", (event) ->
		event.preventDefault()
		neww = window.open $(@).attr("href"), "Share it!", "height=300, width=600"
		if window.focus 
			neww.focus()
		return false
		