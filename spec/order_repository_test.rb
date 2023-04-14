require_relative '../lib/order.rb'
require_relative '../lib/order_repository.rb'

def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
   
RSpec.describe OrderRepository do
    before(:each) do 
        reset_orders_table
    end

    let(:repo) {OrderRepository.new}

    describe '#all' do
        it 'lists all order objects' do
            orders = repo.all
            expect(orders.first.customer).to eq 'John Smith'
            expect(orders.last.date).to eq '2023-05-22'
            expect(orders.length).to eq 2

        end
    end

    describe '#create' do
        it 'creates and adds an order to the table' do
            new_order = Order.new
            new_order.customer = 'Jess Henderson'
            new_order.date = '2023-05-24'
            new_order.item_id = 1

            repo.create(new_order)
            orders = repo.all
            expect(orders.length).to eq 3
            expect(orders.last.item_id).to eq '1'
        end
    end
end