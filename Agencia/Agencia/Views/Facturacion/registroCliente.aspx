<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Cliente
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Informacion de Cliente</h2>
            <div class="ui divider"></div>
        </header>
        <div class="ui segment secondary container text" ng-controller="registroCliente">
            <form class="ui form" method="post" action="/Facturacion/Factura/">
                <div class="field">
                    <div class="ui tertiary  segment">
                        <div class="required disabled field">
                            <label class="ui centered header">Codigo Reservacion:</label>
                            <input type="text" name="codigo" value="<%:ViewBag.id %>" required />
                        </div>
                    </div>
                </div>
                <div class="two fields">
                    <div class="required field">
                        <label>DPI:</label>
                        <input type="text" name="dpi" autofocus required ng-model="dpi" ng-change="buscarUsuario()" placeholder="DPI" />
                    </div>
                    <div class="required field">
                        <label>NIT:</label>
                        <input type="text" name="nit" required ng-model="p.nit" placeholder="NIT" />
                    </div>
                </div>
                <div class="field">
                    <label>Nombres: </label>
                    <div class="two fields">
                        <div class="required field">
                            <input type="text" name="nombres" ng-model="p.nombres" placeholder="Nombres" required />
                        </div>
                        <div class="field">
                            <input type="text" name="apellidos" ng-model="p.apellidos" placeholder="Apellidos" />
                        </div>
                    </div>
                </div>
                <div class="required field">
                    <label>Email:</label>
                    <input type="text" name="email" ng-model="p.email" placeholder="e-mail" required />
                </div>
                <div class="required field">
                    <label>Direccion:</label>
                    <input type="text" name="direccion" ng-model="p.direccion" placeholder="Direccion" required />
                    <div class="two fields">
                        <div class="field">
                            <label>Telefono:</label>
                            <input type="text" name="telefono" ng-model="p.telefono" placeholder="52134568" />
                        </div>
                        <div class="field">

                            <label>Fecha Nacimiento: </label>
                            <input type="date" name="fecha_nac" ng-model="p.fecha_nacimiento" />
                        </div>
                    </div>
                </div>
                <input type="submit" value="Desplegar Factura" class="ui fluid violet button" />
            </form>
        </div>
        <div class="top"></div>
    </section>
</asp:Content>
