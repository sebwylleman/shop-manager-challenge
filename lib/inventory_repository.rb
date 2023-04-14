require_relative 'inventory.rb'
require_relative 'database_connection'

class InventoryRepository
    def all
        sql = 'SELECT * FROM inventory;'
        result_set = DatabaseConnection.exec_params(sql,[])

        inventory = []
        result_set.each do |field|
            stock = Inventory.new
            stock.item = field['item']
            stock.price = field['price']
            stock.quantity = field['quantity']
            inventory << stock
        end

        return inventory
    end

    def create(product)
        sql = 'INSERT INTO inventory (item, price, quantity) VALUES ($1, $2, $3);'
        params = [product.item, product.price, product.quantity] 
        result_set = DatabaseConnection.exec_params(sql, params)

        return nil
    end
end