module LoginHelper
  def log_in(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button "Iniciar sesión"
  end

  def log_out
    first(:link, 'Cerrar').click
  end
end
