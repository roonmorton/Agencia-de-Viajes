<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Reservacion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        Tipo de Reservacion: <%: ViewBag.q %>
        <header class="ui container text">
            <h2 class="ui centered header">Proceso de Reservacion</h2>
            <div class="ui divider"></div>
        </header>
        <section ng-controller="reservacion">
            <div class="ui container text secondary segment">
                <form class="ui form" ng-submit="buscarReservacion()">
                    <div class="field">
                        <label>Codigo Reservacion: </label>
                        <input type="text" ng-model="codigo_res" ng-init="codigo_res='<%:ViewBag.res%>'" />
                    </div>
                    <input type="submit" value="Procesar" class="ui fluid blue button" />
                </form>
            </div>
            <div>
                <div ng-show="articulos.length > 0" class="ui segment ">
                    <h3 class="header">Paquete</h3>

                    <div class="ui divided selection list">
                        <div class="item active">
                            <div class="ui violet horizontal label ">Salida: </div>
                            <strong>{{articulos[0].aeropuerto_salida}}</strong>
                        </div>
                        <div class="item active">
                            <div class="ui violet horizontal label ">Destino: </div>
                            <strong>{{articulos[0].aeropuerto_llegada}}</strong>
                        </div>
                    </div>
                    <table class="ui green celled table">
                        <thead>
                            <tr>
                                <th>Descripcion</th>
                                <th>Cantidad</th>
                                <th>Precio</th>
                                <th>Sub-Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="articulo in articulos">
                                <td>{{articulo.descripcion}}</td>
                                <td>{{articulo.personas}}</td>
                                <td>{{articulo.precio}}</td>
                                <td>{{articulo.subTotal}}</td>
                            </tr>
                            <tr class="warning">
                                <td colspan="3">Total</td>
                                <td>{{total()}}</td>
                            </tr>
                        </tbody>
                    </table>
                    <%If Session("tipo") > 2 Then%>
                    <a href="/Facturacion/registroCliente/{{codigo_res}}" class="ui green button">Proceso de Facturacion</a>
                    <%End If%>
                </div>
            </div>

        </section>
        <div class="top"></div>
    </section>
</asp:Content>
