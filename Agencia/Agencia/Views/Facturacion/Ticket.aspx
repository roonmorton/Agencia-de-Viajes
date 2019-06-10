<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Ticket
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Ticket</h2>
            <div class="ui divider"></div>
        </header>
        <section class="ui secondary segment container text">
            <%If ViewBag.t_reservacion = 1 Or ViewBag.t_reservacion = 2 Then%>
            <%: Html.Partial("_pVueloEconomico")%>
            <%ElseIf ViewBag.t_reservacion = 3 Or ViewBag.t_reservacion = 4 Or ViewBag.t_reservacion = 5 Or ViewBag.t_reservacion = 6 Then%>
            <%: Html.Partial("_pVueloHotelTraslado")%>
            <%ElseIf ViewBag.t_reservacion = 7 Then%>
            <%:Html.Partial("_pCrucero") %>
            <%End If%>
        </section>
    </section>
</asp:Content>
