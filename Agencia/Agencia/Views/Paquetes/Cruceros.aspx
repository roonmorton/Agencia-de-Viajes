<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cruceros a Europa
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Cruceros a Toda Europa</h2>
            <div class="ui divider"></div>
        </header>
        <div class="ui secondary segment " ng-controller="cruceros">
            <form class="ui form" method="post" action="/Paquetes/Lista_Cruceros">
                <div class="required field">
                    <label>Salida:</label>
                    <input type="text" hidden name="puerto" ng-model="puerto" value="" />{{codigo}}
                    <input type="text" name="salida" placeholder="Ciudad o Aeropuerto" ng-model="query" ng-change="buscarCrucero()" required />
                    <div class="ui secondary segment" ng-show="cruceros.length > 0">
                        <div class="ui middle aligned divided list">
                            <div class="item" ng-repeat="crucero in cruceros">
                                <img class="ui avatar image" src="/Content/img/location.png">
                                <div class="content">
                                    <a href="" ng-click="cambioCrucero(crucero.codigo_puerto,crucero.crucero)">{{crucero.crucero}}</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="required field">
                    <label>Fecha:</label>
                    <input type="date" name="fecha" required  />
                </div>
                <div class="required field">
                    <label>Personas:</label>
                    <select name="pasajeros" required>
                        <option value="">-- Personas para la Reservacion --</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                </div>
                <input type="submit" value="Buscar" class="ui flui green button" />
            </form>
        </div>
        <div class="top"></div>
    </section>

</asp:Content>
