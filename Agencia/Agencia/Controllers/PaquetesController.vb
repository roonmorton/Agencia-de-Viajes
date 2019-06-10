Imports System.Data
Public Class PaquetesController
	Inherits System.Web.Mvc.Controller

	Dim db As New agencia_viajes_condorEntities1
	'
	' GET: /Paquetes

	Function Vuelos() As ActionResult
		Return View()
	End Function

	<HttpPost>
	Function Lista_Vuelos(codigo_salida As String, salida As String, codigo_destino As String,
			destino As String, fecha As String, personas As String, tipo_vuelo As String) As ActionResult
		ViewBag.pasajeros = personas
		If tipo_vuelo = 1 Then
			Return View(db.vuelos(fecha, codigo_salida, codigo_destino, personas, tipo_vuelo))
		ElseIf tipo_vuelo = 2 Then
			Return View(db.vuelos(fecha, codigo_salida, codigo_destino, personas, tipo_vuelo))
		Else
			Return RedirectToAction("Vuelos")
		End If
	End Function

	<HttpPost>
	Function Lugares(salida As String) As ActionResult
		Return Json(db.salida(salida))
	End Function

	<HttpPost>
	Function Destinos(destino As String) As ActionResult
		Return Json(db.destinos(destino))
	End Function

	Function Reservar(vuelo As String, destino As String, tipo As String, pasajeros As String,
					  desayuno As String, habitacion_simple As String, habitacion_doble As String,
					 traslado As String, hotel As String, crucero As String
					  )

		Dim var As Object
		If vuelo <> "" And hotel <> "" Then
			If traslado <> "" Then
				If tipo = 1 Then
					var = db.reservar_vuelo_Hotel_Traslado_e(destino, vuelo, pasajeros, desayuno, habitacion_simple, habitacion_doble, hotel, Session("codigo_user")).FirstOrDefault
					ViewBag.q = "vuelo Economico + hotel con traslado"
				ElseIf tipo = 2 Then
					var = db.reservar_vuelo_Hotel_Traslado_p(destino, vuelo, pasajeros, desayuno, habitacion_simple, habitacion_doble, hotel, Session("codigo_user")).FirstOrDefault
					ViewBag.q = "vuelo Primera Clase + hotel con traslado"
				End If
			Else
				If tipo = 1 Then
					var = db.reservar_vuelo_Hotel_e(destino, vuelo, pasajeros, desayuno, habitacion_simple, habitacion_doble, hotel, Session("codigo_user")).FirstOrDefault
					ViewBag.q = "vuelo Economico + hotel sin traslado"
				ElseIf tipo = 2 Then
					var = db.reservar_vuelo_Hotel_p(destino, vuelo, pasajeros, desayuno, habitacion_simple, habitacion_doble, hotel, Session("codigo_user")).FirstOrDefault
					ViewBag.q = "vuelo Primera Clase+ hotel sin traslado"
				End If
			End If
		ElseIf vuelo <> "" Then
			var = db.reservarVuelo(tipo, vuelo, destino, 1, pasajeros).FirstOrDefault
			ViewBag.q = "vuelo"
		ElseIf crucero <> "" Then
			var = db.reservar_crucero(1, crucero, pasajeros).FirstOrDefault
			ViewBag.q = "Crucero"
		
		End If

		ViewBag.res = var
		Return View()
	End Function

	<HttpPost>
	Function detalleReservacion(reservacion As String) As ActionResult
		Return Json(db.detalleVuelo(reservacion))
	End Function



	Function Vuelo_Hotel() As ActionResult

		Return View()
	End Function

	<HttpPost>
	Function Lista_Vuelo_Hotel(codigo_salida As String, salida As String, codigo_destino As String, destino As String,
							   fecha As String, personas As String, tipo_vuelo As String, desayuno As String,
							   habitacion_simple As String, habitacion_doble As String, traslado As String) As ActionResult
		Dim vh As New vueloHotel
		vh.destino = codigo_destino
		vh.pasajeros = personas
		vh.tipo = tipo_vuelo
		vh.desayuno = desayuno
		vh.habitacion_simple = habitacion_simple
		vh.habitacion_doble = habitacion_doble
		vh.traslado = traslado
		ViewBag.vh = vh

		Return View(db.vuelos(fecha, codigo_salida, codigo_destino, personas, tipo_vuelo))
	End Function

	Function Lista_Hoteles(vuelo As String, destino As String, tipo As String, pasajeros As String, desayuno As String,
						   habitacion_simple As String, habitacion_doble As String, traslado As String)
		Dim vh As New vueloHotel
		vh.destino = destino
		vh.vuelo = vuelo
		vh.pasajeros = pasajeros
		vh.tipo = tipo
		vh.desayuno = desayuno
		vh.habitacion_simple = habitacion_simple
		vh.habitacion_doble = habitacion_doble
		vh.traslado = traslado
		ViewBag.vh = vh

		Return View(db.lista_hotel(destino, habitacion_doble, habitacion_simple))
	End Function

	Function Cruceros() As ActionResult
		Return View()
	End Function

	<HttpPost>
	Function Lista_Cruceros(puerto As String, fecha As String, pasajeros As String) As ActionResult
		ViewBag.fecha = fecha
		ViewBag.pasajeros = pasajeros
		Return View(db.listar_cruceros(puerto, fecha, pasajeros))
	End Function

	<HttpPost>
	Function ver_cruceros(query As String) As ActionResult
		Return Json(db.ubicar_crucero(query))
	End Function



End Class