<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage(Of IEnumerable (Of Agencia.vuelos_Result))" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Lista_Vuelos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Vuelos Disponibles</h2>
            <div class="ui divider"></div>
        </header>
        <% For Each item In Model%>
        <div class="ui secondary segment">
            <div class="ui grid">
                <div class="eleven wide column" style="border-right: 1px solid rgba(34,36,38,.15);">
                    <div class="ui relaxed divided list">
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Salida:</span>
                                <div class="description"><%:item.aeropuerto_salida %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">LLegada:</span>
                                <div class="description"><%: item.aeropuerto_llegada%></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Capacidad:</span>
                                <div class="description"><%: item.no_asientos %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Reservaciones en Economicos:</span>
                                <div class="description"><%:item.pasajeros_economico%></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Reservaciones en Primera Clase</span>
                                <div class="description"><%: item.pasajeros_primera%></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="five wide column">
                    <div class="ui relaxed divided list">
                        
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Fecha Salida: </span>
                                <div class="description"><%: item.fecha_salida%></div>
                            </div>
                        </div>
                        <%--<div class="item">
                            <div class="content">
                                <span class="ui green header">Codigo Vuelo:</span>
                                <div class="description"><%: item.codigo_vuelo%></div>
                            </div>
                        </div>--%>
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Precio Vuelo:</span>
                                <div class="description"><%: item.precio_vuelo %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Cantidad de Reservaciones:</span>
                                <div class="description"><%:ViewBag.pasajeros %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="ui green header">Gasto Total: </div>
                            <div class="description"><%: (item.precio_vuelo * (CInt(ViewBag.pasajeros))) %></div>
                        </div>
                        
                    </div>
                    <%: Html.ActionLink("Cotizar", "Reservar", New With {.vuelo = item.codigo_vuelo, .destino = item.destino, .tipo = item.tipo, .pasajeros = ViewBag.pasajeros},New With {.class="ui fluid violet button"})%>
                </div>
            </div>
        </div>
        <%Next%>

        <div class="top"></div>
    </section>
</asp:Content>
