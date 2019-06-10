Imports System.Data
Public Class FacturacionController
	Inherits System.Web.Mvc.Controller

	'
	' GET: /Facturacion
	Private db As New agencia_viajes_condorEntities1


	Function registroCliente(id) As ActionResult
		ViewBag.id = id
		Return View()
	End Function

	<HttpPost>
	Function Factura(nit As String, codigo As String, nombres As String, apellidos As String, direccion As String, telefono As String, fecha_nac As String, dpi As String) As ActionResult
		Dim cliente As List(Of buscarCliente_Result) = db.buscarCliente(dpi).ToList()
		If cliente.Count > 0 Then
			ViewBag.cliente = cliente.FirstOrDefault.codigo
		Else
			Dim obj As String = db.AgregarCliente(nombres, apellidos, direccion, dpi, direccion, telefono, fecha_nac, nit).FirstOrDefault
			ViewBag.cliente = obj
		End If
		ViewBag.reservacion = codigo
		ViewBag.nombres = nombres
		ViewBag.apellidos = apellidos
		ViewBag.nit = nit

		Return View()
	End Function

	<HttpPost>
	Function Ticket(cliente As String, reservacion As String, fecha As String, pago As String, efectivo As String, debito As String, credito As String) As ActionResult
		Dim tipo_r As String = db.obtenerReservacion(reservacion).FirstOrDefault
		ViewBag.t_reservacion = tipo_r
		' Tipo corresponde a el tipo de reservacion que se realizo, 
		'1 vuelo economico
		'2 vuelo Primera clase
		'3 vuelo + hotel economico + traslado
		'4 vuelo + hotel primera clase + traslado

		'5 vuelo + hotel economico 
		'6 vuelo + hotel primera clase
		'7 crucero
		If tipo_r = 1 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_Vuelo_E(ViewBag.cod_fac))
		ElseIf tipo_r = 2 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_Vuelo_E(ViewBag.cod_fac))
		ElseIf tipo_r = 3 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_Vuelo_Hotel(ViewBag.cod_fac))

		ElseIf tipo_r = 4 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_Vuelo_Hotel(ViewBag.cod_fac))

		ElseIf tipo_r = 5 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_Vuelo_Hotel(ViewBag.cod_fac))

		ElseIf tipo_r = 6 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_Vuelo_Hotel(ViewBag.cod_fac))

		ElseIf tipo_r = 7 Then
			ViewBag.cod_fac = db.Facturar(reservacion, fecha, pago, efectivo, credito, debito, cliente).FirstOrDefault()
			Return PartialView(db.ticket_crucero(ViewBag.cod_fac))

		End If
		Return View()
	End Function

	<HttpPost>
	Function buscarPersona(dpi As String) As ActionResult
		Return Json(db.buscarCliente(dpi))
	End Function

	



End Class