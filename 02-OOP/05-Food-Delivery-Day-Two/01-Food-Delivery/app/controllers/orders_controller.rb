require_relative '../views/view'
require_relative '../views/orders_view'
require_relative '../repositories/order_repository'
require_relative '../views/sessions_view'
require 'csv'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @meal_repository = meal_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @view = View.new
    @sessions_view = SessionsView.new
  end

  def add
    meals = @meal_repository.all
    @view.listing_meal(meals)
    index = @sessions_view.ask_for_integer(:meal).to_i - 1
    meal = meals[index]
    customers = @customer_repository.all
    @view.listing_customer(customers)
    index = @sessions_view.ask_for_integer(:customer).to_i - 1
    customer = customers[index]
    employees = @employee_repository.all_riders
    @view.listing_employee(employees)
    index = @sessions_view.ask_for_integer(:employee).to_i - 2
    employee = employees[index]
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
    list_undelivered_orders
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders
    my_orders = orders.select { |order| order.employee == employee }
    @orders_view.display(my_orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    delivered_order = @sessions_view.ask_for_integer(:meal) - 1
    mark = @order_repository.undelivered_orders.select { |order| order.employee == employee }
    mark[delivered_order].deliver!
    @order_repository.save_csv
  end
end
