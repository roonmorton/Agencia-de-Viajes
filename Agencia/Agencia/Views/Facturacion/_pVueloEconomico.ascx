<%@ Control Language="VB" Inherits="System.Web.Mvc.ViewUserControl(Of IEnumerable (Of Agencia.ticket_Vuelo_E_Result))" %>

<% Dim var As List(Of Agencia.ticket_Vuelo_E_Result) = Model.ToList%>
<section>
    <div>
        <h4 class="ui horizontal divider header">Código Factura: <%= var.Item(0).codigo_factura  %></h4>
        <h4 class="ui horizontal divider header">Fecha Factura: <%= var.Item(0).fecha   %></h4>
        
    </div>
    <header class="ui segment secondary">
        <h3 class="ui header centered">Ticket de Vuelo</h3>
        <div>Cliente:<strong><%: var.Item(0).nombres + " " +var.Item(0).apellidos  %></strong></div>
        <div>Nit:<strong><%: var.Item(0).nit %></strong></div>
    </header>
    <article>
        <ol class="ui list">
            <li value="*">Informacion de Vuelo
      <ol>
          <li value="">Codigo Vuelo: <strong><%: var.Item(0).codigo_vuelo  %></strong>

          </li>
          <li value="">Fecha Salida: <strong><%: var.Item(0).fecha_salida  %></strong>

          </li>
          <li value="">Aeropuerto Salida: <strong><%: var.Item(0).aeropuerto_salida%></strong>

          </li>
          <li value="">Aeropuerto Destino: <strong><%: var.Item(0).aeropuerto_llegada %></strong>

          </li>
      </ol>
            </li>
            <li value="*">Detalle Reservacion:
    <ol>
        <li value="">Tipo Boleto: <strong><%: var.Item(0).descripcion  %></strong>
        </li>
        <li value="">Cantidad de Asientos: <strong><%: var.Item(0).personas %></strong>
        </li>
        <li value="">Numero de Asientos: <%Dim i As Integer = 0
                                             If var.Item(0).tipo = 1 Then
                                                 For i = 1 To var.Item(0).personas%>
            <%: "E" + (var.Item(0).no_asiento + i).ToString + ","%>
            <%Next
            Else
                For i = 1 To var.Item(0).personas%>
            <%: "A" + (var.Item(0).no_asiento + i).ToString + ","%>
            <%Next
            End If%>
        </li>
        <li value="">Total Cancelado:  <strong><%: (var.Item(0).precio * (var.Item(0).personas) ) %></strong>
        </li>
    </ol>
            </li>
        </ol>
        <div class="ui segment">
            <table class="ui green  table">
                <thead>
                    <tr>
                        <th>Descripcion</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Sub-Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% Dim total As Integer
                        For Each item In var%>
                    <tr>
                        <td><%:item.descripcion %></td>
                        <td><%: item.personas %></td>
                        <td><%:item.precio  %></td>
                        <td><%:(item.precio*item.personas ).ToString%></td>
                        <%total = total + (item.precio * item.personas)%>
                    </tr>
                    <%Next%>

                    <tr class="warning">
                        <td colspan="3">Total</td>
                        <td><%:total %></td>
                    </tr>
                </tbody>
            </table>
        </div>

    </article>
</section>

<table>
</table>
