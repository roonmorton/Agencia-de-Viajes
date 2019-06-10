<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Shared/MasterPage.Master" Inherits="System.Web.Mvc.ViewPage(Of IEnumerable (Of Agencia.listar_cruceros_Result))" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Lista de Cruceros
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
        <div class="top"></div>
        <header class="ui container text">
            <h2 class="ui header ">Cruceros Disponibles</h2>
            <div class="ui divider"></div>
        </header>
        <div class="top"></div>

        <% For Each item In Model%>
        <article class="ui secondary segment ">
            <div class="ui grid">
                <div class="five wide column">
                    <img src="/Content/img/hotel.jpg" class="img-hotel " />
                </div>
                <div class="eleven wide column">
                    <div class="ui relaxed divided list">
                        <div class="item">
                            <div class="ui grid">
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="header">Crucero:</span>
                                        <div class="description"><%: item.d_crucero  %></div>
                                    </div>
                                </div>
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="header">Salida:</span>
                                        <div class="description"><%: item.salida  %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="header">Fecha Salida:</span>
                                <div class="description"><%:item.fecha_salida  %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="ui grid">
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="header">Max Cantidad de Pasajeros:</span>
                                        <div class="description"><%:item.pasajeros  %></div>
                                    </div>
                                </div>
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="header">Reservados:</span>
                                        <div class="description"><%:item.reservados  %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <span class="header">Precio C/U pasaje:</span>
                                <div class="description"><%:item.precio %></div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="ui grid">
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="header">Cantidad de Pasajes :</span>
                                        <div class="description"><%: ViewBag.pasajeros %></div>
                                    </div>
                                </div>
                                <div class="eight wide column">
                                    <div class="content">
                                        <span class="header">Costo total de Reservaciones:</span>
                                        <div class="description"><%: (item.precio*ViewBag.pasajeros).ToString  %></div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <%: Html.ActionLink("Cotizar", "Reservar",New With {.crucero = item.codigo_crucero,.pasajeros = ViewBag.pasajeros},New with{.class="ui fluid teal button"})%>
                </div>

            </div>

        </article>

        <% Next%>
    </section>



</asp:Content>
