require_relative '../models/order'
require_relative '../repositories/customer_repository'
require_relative '../repositories/employee_repository'
require_relative '../repositories/meal_repository'
require 'csv'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    @order = Order.new
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end

  def create(new_order)
    new_order.id = @next_id
    @orders << new_order
    @next_id += 1
    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def deliver(mark)
    @orders[mark].deliver!
  end



  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << %w[id meal_id customer_id employee_id delivered]
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      @orders << Order.new(
        { id: row[:id].to_i,
          meal: @meal_repository.find(row[:meal_id].to_i),
          customer: @customer_repository.find(row[:customer_id].to_i),
          employee: @employee_repository.find(row[:employee_id].to_i),
          delivered: row[:delivered] == "true" }
      )
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end
end
