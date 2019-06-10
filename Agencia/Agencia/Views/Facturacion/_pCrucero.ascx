<%@ Control Language="VB" Inherits="System.Web.Mvc.ViewUserControl(Of IEnumerable (Of Agencia.ticket_crucero_Result))" %>

<% Dim var As List(Of Agencia.ticket_crucero_Result) = Model.ToList%>
<section>
    <div>
        <h4 class="ui horizontal divider header">Código Factura: <%= var.Item(0).codigo_factura  %></h4>
        <h4 class="ui horizontal divider header">Fecha Factura: <%= var.Item(0).fecha   %></h4>
    </div>
    <header class="ui segment secondary">
        <h3 class="ui header centered">Tieket Crucero</h3>
        <div>Cliente:<strong><%: var.Item(0).nombres + " " +var.Item(0).apellidos  %></strong></div>
        <div>Nit:<strong><%: var.Item(0).nit %></strong></div>
    </header>
    <article>
        <ol class="ui list">
            <li value="*">Informacion de Crucero
      <ol>
          <li value="">Codigo Crucero: 
              <strong>
                  <%: var.Item(0).codigo_crucero %>
              </strong>
          </li>
          <li value="">Crucero:
              <strong><%: var.Item(0).item + var.Item(0).crucero  %></strong>
          </li>
          <li value="">Fecha Salida: 
              <strong><%: var.Item(0).fecha_salida  %></strong>
          </li>
          <li value="">Puerto Salida: 
              <strong><%: var.Item(0).puerto %></strong>
          </li>
      </ol>
            </li>
            <li value="*">Detalle Crucero:
    <ol>
        <li value="">Precio Boleto: <strong><%: var.Item(0).precio    %></strong>
        </li>
        <li value="">Cantidad de Boletos: <strong><%: var.Item(0).cantidad  %></strong>
        </li>
        <li value="">Total Cancelado:  <strong><%: (var.Item(0).precio * (var.Item(0).cantidad ) ) %></strong>
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
                    <%Dim total As Integer%>
                    <% For Each item In var%>
                    <tr>
                        <td><%:item.item %></td>
                        <td><%: item.cantidad%></td>
                        <td><%:item.precio  %></td>
                        <td><%:(item.precio*item.cantidad ).ToString%></td>
                        <%total = total + (item.precio * item.cantidad)%>
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
