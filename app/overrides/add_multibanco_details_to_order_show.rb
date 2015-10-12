Deface::Override.new(
  :virtual_path => 'spree/shared/_order_details',
  :name => 'add_multibanco_details_to_order_show',
  :insert_bottom => ".payment-info",
  :text => %q{
    <% if multibanco_payment = @order.payments.from_multibanco.first %>
      <table>
        <tr>
          <td><%= Spree.t(:multibanco_entity) %></td>
          <td><%= multibanco_payment.multibanco_provider.entity %></td>
        </tr>
        <tr>
          <td><%= Spree.t(:multibanco_reference) %></td>
          <td><%= multibanco_payment.multibanco_reference %></td>
        </tr>
        <tr>
          <td><%= Spree.t(:amount) %></td>
          <td><%= @order.display_item_total.to_html %></td>
        </tr>
      </table>
    <% end %>
  }
)
