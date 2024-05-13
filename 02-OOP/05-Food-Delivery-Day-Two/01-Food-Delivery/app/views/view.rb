class View
  def meal_name
    puts "What is the name of the meal?"
    return gets.chomp
  end

  def meal_price
    puts "How much does it cost?"
    return gets.chomp
  end

  def listing_meal(list)
    list.each do |food|
      puts "#{food.id} - #{food.name} - #{food.price}"
    end
  end

  def listing_customer(list)
    list.each do |customer|
      puts "#{customer.id} - #{customer.name} - #{customer.address}"
    end
  end

  def listing_employee(list)
    list.each do |employee|
      puts "#{employee.id} - #{employee.username}"
    end
  end

  def customer_name
    puts "What is the customers name?"
    return gets.chomp
  end

  def customer_address
    puts "What is the customers address?"
    return gets.chomp
  end

  def ask_for_delete_index
    puts "What id number would you like to delete?"
    return gets.chomp.to_i
  end

  def wrong_credentials
    puts "wrong username/password"
  end

  def meal_index
    puts "What meal index number would you like to select?"
    gets.chomp.to_i
  end

  def customer_index
    puts "What customer index number would you like to select?"
    gets.chomp.to_i
  end
end
