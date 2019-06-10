Public Class loginController
    Inherits System.Web.Mvc.Controller

    '
	' GET: /login
	Dim db As New agencia_viajes_condorEntities1


	Function login() As ActionResult
		Return View()
	End Function

	<HttpPost>
	Function login(user As String, pass As String) As ActionResult
		Dim list As List(Of login_Result) = db.login(pass, user).ToList
		If list.Count > 0 Then
			Session("codigo_user") = list.Item(0).codigo
			Session("usuario") = (list.Item(0).nombres + " " + list.Item(0).apellidos)
			Session("tipo") = list.Item(0).tipo

			Return RedirectToAction("Index", "Home", False)
		Else
			Return View()
		End If
	End Function

	Function logoff() As ActionResult
		Session.Abandon()
		Return RedirectToAction("login", "login", False)
	End Function

End Class