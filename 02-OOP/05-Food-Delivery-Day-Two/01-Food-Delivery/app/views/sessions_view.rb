class SessionsView
  def ask_user_for(stuff)
    puts "#{stuff.capitalize}?"
    print "> "
    return gets.chomp
  end

  def ask_for_integer(stuff)
    puts "#{stuff.capitalize}?"
    print "> "
    return gets.chomp.to_i
  end

  def print_wrong_credentials
    puts "Wrong credentials"
  end
end
