<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
    End Sub
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Agencia Viajes el Condor
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">PAQUETES</h2>
            <div class="ui divider"></div>
        </header>
        <section>
            <div class="ui three column grid">
                <div class="column">
                    <div class="ui fluid card">
                        <img class="img_link" src="/Content/img/vuelo_link.jpg">
                        <%: Html.ActionLink("Vuelo", "Vuelos", "Paquetes",False,New With {.class="ui bottom green attached button"})%>
                    </div>
                </div>
                <div class="column">
                    <div class="ui fluid card">
                        <img class="img_link" src="/Content/img/vuelo_hotel_link.jpg">
                        <%: Html.ActionLink("Vuelo + Hotel { Traslados }", "Vuelo_Hotel", "Paquetes", False, New With {.class = "ui bottom green attached button"})%>
                    </div>
                </div>
                <div class="column">
                    <div class="ui fluid card">
                        <img class="img_link" src="/Content/img/crucero_link.jpg">
                        <%: Html.ActionLink("Crucero", "Cruceros", "Paquetes", False, New With {.class = "ui bottom green attached button"})%>
                    </div>
                </div>
            </div>
        </section>
        <div class="top"></div>
    </section>
</asp:Content>
