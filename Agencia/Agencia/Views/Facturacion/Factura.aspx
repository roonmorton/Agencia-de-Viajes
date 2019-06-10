<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Factura
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Factura</h2>
            <div class="ui divider"></div>
        </header>
        <div ng-controller="factura" class="ui segment">
            <form class="ui form" method="post" action="/Facturacion/Ticket/">
                <div class="field">
                    <div class="ui secondary segment">
                        <div class="two fields">
                            <div class="required disabled field">
                                <label>Codigo Cliente:</label>
                                <input type="text" name="cliente" ng-init="cliente='<%: ViewBag.cliente %>'" ng-model="cliente" />
                            </div>
                            <div class="required disabled field">
                                <label>Codio Reservacion:</label>
                                <input type="text" name="reservacion" ng-init="reservacion='<%: ViewBag.reservacion %>'" ng-model="reservacion" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="two fields">
                    <div class="required field">
                        <label>Nombres: </label>
                        <input type="text" value="<%:ViewBag.nombres + " " + ViewBag.apellidos %>" disabled />
                    </div>
                    <div class="required field">
                        <label>NIT:</label>
                        <input type="text" value="<%: ViewBag.nit %>" disabled  />
                        
                    </div>
                </div>
                <div class="two fields">
                    <div class="required field">
                        <label>Fecha:</label>
                        <input type="date" name="fecha" ng-model="fecha" />
                    </div>
                    <div class="required field">
                        <label>Tipo Pago:</label>
                        <select name="pago" ng-model="pago" ng-change="pagos(pago)" required>
                            <option value="">-- Metodo de Pago --</option>
                            <option value="1">Efectivo</option>
                            <option value="2">Credito</option>
                            <option value="3">Debito</option>
                            <option value="4">Efectivo + Credito</option>
                            <option value="5">Efectivo + Debito</option>
                            <option value="6">Efectivo + Credito + Debito</option>
                        </select>
                    </div>
                </div>
                <div class="three fields">
                    <div class="required field" ng-show="(pago == 1 || pago == 4 || pago == 5 || pago == 6)">
                    <label>Monto en Efectivo: </label>
                    <div class="ui labeled input">
                        <div class="ui label">$$: </div>
                        <input type="text" name="efectivo" />
                    </div>
                </div>
                <div class="required field" ng-show="(pago ==2 || pago == 4 || pago == 6 )">
                    <label>Monto en Credito: </label>
                    <div class="ui labeled input">
                        <div class="ui label">$$: </div>
                        <input type="text" name="Credito" />
                    </div>
                </div>
                <div class="required field" ng-show="(pago == 3 || pago == 5 || pago == 6)">
                    <label>Monto para Debito: </label>
                    <div class="ui labeled input">
                        <div class="ui label">$$:</div>
                        <input type="text" name="Debito" />
                    </div>
                </div>
                </div>
                <div class="ui fluid large buttons">
                        <input type="submit" value="Facturar & Generar Ticket" class="ui green button"/>
                        <div class="Or"></div>
                        <a href="" ng-click="verDetalle()" class="ui teal button">Ver Detalle de Factura</a>
                    </div>
                <div ng-show="articulos.length > 0" class="ui secondary segment ">
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
                </div>
            </form>
        </div>
    </section>

</asp:Content>

                        