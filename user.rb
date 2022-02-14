require 'active_support/inflector'

require_relative 'jml_db'

class User < JmlDb; end

# user = User.new
# user.test
# puts User.create(name: 'Patrik', email: 'pat@mail.ru', phone_number: '9883').inspect
# puts user.inspect
# puts User.where(name: '').inspect
# puts "#{users}\n\n\n"
# puts user = users.first
# puts user.name
# puts user.update(name: 'Lera', email: 'ler@mail.ru', phone_number: '0909').inspect
# puts user.id
# puts user.inspect
# user.delete
# puts User.find(250).inspect
# puts User.find_by("name = 'Dori'").inspect

