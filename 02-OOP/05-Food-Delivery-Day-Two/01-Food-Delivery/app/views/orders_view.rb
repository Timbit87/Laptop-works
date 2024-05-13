class OrdersView
  def display(orders)
    orders.each_with_index do |order, index|
      puts "(#{index + 1}) #{order.employee.username}: #{order.meal.name} | #{order.customer.name}"
    end
  end
end
