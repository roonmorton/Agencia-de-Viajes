<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage(Of IEnumerable (Of Agencia.lista_hotel_Result))" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Hoteles Disponibles
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui centered header">Hoteles Disponibles</h2>
            <div class="ui divider"></div>
        </header>
        <% For Each item In Model%>
        <div class="ui secondary segment">
            <div class="ui  grid">
                <div class="eleven wide column">
                    <div class="ui relaxed divided list">
                        <div class="item">
                            <div class="ui grid">
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="ui green header">Hotel:</span>
                                        <div class="description"><%:item.descripcion  %></div>
                                    </div>
                                </div>
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="ui green header">Ubicacion:</span>
                                        <div class="description"><%: item.direccion + ", "+ item.departamento + ", "+ item.pais %></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">
                            <div class="content">
                                <span class="ui green header">Ubicacion:</span>
                                <div class="description"><%: item.direccion + ", "+ item.departamento + ", "+ item.pais %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="ui grid">
                                <%If ViewBag.vh.habitacion_simple > 0 Then%>
                                <div class="eight wide column">
                                    <div class="item">
                                        <div class="content">
                                            <span class="ui green header">Reservar Habitaciones Simples:</span>
                                            <div class="description"><strong><%: ViewBag.vh.habitacion_simple %> </strong><span class="ui violet header">Precio: c/u </span><%: item.p_habitacion_simple %></div>
                                        </div>
                                    </div>
                                </div>
                                <%    End If%>
                                <%If ViewBag.vh.habitacion_doble > 0 Then%>
                                <div class="eight wide column">
                                    <div class="item">
                                        <div class="content">
                                            <span class="ui green header">Reservar Habitaciones Doble</span>
                                            <div class="description"><strong><%: ViewBag.vh.habitacion_doble %></strong>  <span class="ui violet header">Precio: c/u</span><%: item.p_habitacion_doble %></div>
                                        </div>
                                    </div>
                                </div>
                                <%End If%>
                            </div>
                        </div>

                        <div class="item">
                            <div class="ui grid">
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="ui red header">Gasto Total de Hotel:</span>
                                        <div class="description"><%: (item.p_habitacion_simple * ViewBag.vh.habitacion_simple)+( item.p_habitacion_doble * ViewBag.vh.habitacion_doble ) %></div>
                                    </div>
                                </div>
                                <div class="eight wide column">
                                    <% If ViewBag.vh.traslado <> "" Then%>
                                    <div class="ui blue header">Gasto Extra (Traslado)</div>
                                    <div class="description">SI</div>
                                    <%End If%>
                                </div>
                            </div>

                        </div>

                    </div>
                    <%ViewBag.vh.hotel = item.codigo_hotel%>
                    <%: Html.ActionLink("Cotizar", "Reservar",ViewBag.vh,New With{.class="ui fluid violet button"})%>
                </div>

                <div class="five wide column">
                    <img src="/Content/img/hotel.jpg" class="img-hotel " />
                </div>
            </div>
        </div>

        <%Next%>
    </section>
</asp:Content>
