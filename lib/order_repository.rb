require_relative 'order.rb'
require_relative 'database_connection.rb'

class OrderRepository
    def all
        sql = 'SELECT * FROM orders;'
        result_set = DatabaseConnection.exec_params(sql,[])

        orders = []
        result_set.each do |field|
            order = Order.new
            order.customer = field['customer']
            order.date = field['date']
            order.item_id = field['item_id']
            orders << order
        end

        return orders
    end

    def create(order)

    end
end