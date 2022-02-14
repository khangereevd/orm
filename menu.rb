require 'active_support/inflector'

require_relative 'jml_db'

class Menu < JmlDb; end

# menu = Menu.new
# user.test
# puts Menu.create(name: 'Khinkal', comment: 'Avar Khink', price: '350').inspect
# puts Menu.inspect
# puts Menu.where(name: 'Nidk').inspect
# puts "#{users}\n\n\n"
# puts Menu = users.first
# puts Menu.name
# puts Menu.update(name: 'Lera', email: 'ler@mail.ru', phone_number: '0909').inspect
# puts Menu.id
# puts Menu.inspect
# menu.delete
# puts Menu.find(250).inspect
# puts Menu.find_by("name = 'Dori'").inspect