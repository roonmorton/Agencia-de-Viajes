<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Reservacion Vuelo + Hotel
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Reservacion Vuelo con Hotel</h2>
            <div class="ui divider"></div>
        </header>
        <div class="ui segment container text" ng-controller="vuelos">
            <form class="ui form" method="post" action="/Paquetes/Lista_Vuelo_Hotel">
                <div class="two fields">
                    <div class="required field">
                        <input type="text" hidden name="codigo_salida" ng-model="codigo_salida" value="" />
                        <label>Salida:</label>
                        <input type="text" placeholder="Ciudad o Aeropuerto" name="salida" ng-model="salida" ng-change="buscarLugar()" autofocus required />
                        <div class="ui secondary segment" ng-show="lugares.length > 0">
                            <div class="ui middle aligned divided list">
                                <div class="item" ng-repeat="lugar in lugares">
                                    <img class="ui avatar image" src="/Content/img/location.png">
                                    <div class="content">
                                        <a href="" ng-click="cambioLugar(lugar.ubicacion,lugar.codigo_aeropuerto)">{{lugar.ubicacion}}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="required field">
                        <input type="text" hidden name="codigo_destino" ng-model="codigo_destino" value="" />
                        <label>Destino:</label>
                        <input type="text" placeholder="Ciudad o Aeropuerto" name="destino" ng-model="destino" ng-change="buscarDestino()" required />
                        <div class="ui secondary segment" ng-show="destinos.length > 0">
                            <div class="ui middle aligned divided list">
                                <div class="item" ng-repeat="destino in destinos">
                                    <img class="ui avatar image" src="/Content/img/location.png">
                                    <div class="content">
                                        <a href="" ng-click="cambiarDestino(destino.descripcion_t,destino.codigo)">{{destino.descripcion_t}}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="two fields">
                    <div class="required field">
                        <label>Fecha:</label>
                        <input type="date" name="fecha" required />
                    </div>
                    <div class="required field">
                        <label>Personas:</label>
                        <select name="personas" required >
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                    </div>
                </div>
                <div class="required field">
                    <label>Tipo de Vuelo:</label>
                    <select name="tipo_vuelo">
                        <option value="1">Economico</option>
                        <option value="2">Primera Clase</option>
                    </select>
                </div>
                <div class="ui secondary segment">
                    <div class="field">
                        <label class="ui horizontal divider header">Informacion de Hotel</label>
                        <div class="required field">
                    <label>Desayunos:</label>
                    <select name="desayuno">
                        <option value="1">Desayuno Normal</option>
                        <option value="2">Desayuno Tipo Buffet</option>
                    </select>
                </div>
                <div class="ui segment">
                    <label>Habitaciones:</label>
                    <div class="two fields">
                        <div class="required field">
                            <label>Habitacion Simple</label>
                            <input type="text" value="0" placeholder="Cantidad" name="habitacion_simple" required  />
                        </div>
                        <div class="required field">
                            <label>Habitacion Doble</label>
                            <input type="text" value="0" placeholder="Cantidad" name="habitacion_doble" required  />
                        </div>
                    </div>
                </div>
                <div class="ui secondary green segment">
                    <div class="inline field">
                        <div class="ui checkbox">
                            <input type="checkbox" value="1" name="traslado" />
                            <label>Traslados (Opcional)</label>
                        </div>
                    </div>
                </div>
                    </div>
                </div>
                <input type="submit" value="Buscar" class="ui fluid button green" />
            </form>
        </div>
        <div class="top"></div>
    </section>

</asp:Content>
