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
        end
    end
end