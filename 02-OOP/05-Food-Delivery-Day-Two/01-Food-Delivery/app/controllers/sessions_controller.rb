require_relative '../views/view'
require_relative '../views/sessions_view'
require_relative '../models/employee'
require_relative '../repositories/employee_repository'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # ask the user for username
    username = @sessions_view.ask_user_for('username')
    # ask the user for their password
    password = @sessions_view.ask_user_for('password')
    # ask the repo for the said user insatnce
    employee = @employee_repository.find_by_username(username)
    # check if the password matches
    # if so, return that employee instance
    return employee if employee && employee.password == password
    @sessions_view.print_wrong_credentials
    # else ask for their username and password again
    login
  end
end
