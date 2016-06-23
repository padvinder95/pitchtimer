window.primus = new Primus()

primus.on 'open', ->
	primus.write
		message: "This is a new client connecting"

primus.on 'reload', ->
	console.log 'reloading'
	location.reload()

primus.on 'rpt_heartbeat', (ts) ->
	# Want to do anything?

primus.on 'data', (data) ->
	console.log 'data', data

send_action = (action, data) ->
	primus.emit 'timer', {"action": action, "data": data}

parseTime = (t) ->
	t = "0#{t}".split(':')
	if t.length == 2
		parseInt(t[0])*60 + parseInt(t[1])
	else
		parseInt(t[0])

$ ->
	
	$('#start').click ->
		send_action 'start', {}
	$('#stop').click ->
		send_action 'stop', {}
	$('#set_time').click ->
		send_action 'set_time', parseTime $('#timeleft').val()
	$('#reset_time').click ->
		$('#timeleft').val $('#T').val()
		$('#set_time').click()
	$('#set_period').click ->
		send_action 'set_period', parseTime $('#T').val()
	
	$('#T,#timeleft').keydown (event) ->
		if event.which == 13
			if $(this).attr('id') == 'T'
				$('#set_period').click()
			else
				$('#set_time').click()