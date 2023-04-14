require_relative '../lib/inventory.rb'
require_relative '../lib/inventory_repository.rb'

def reset_inventory_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end
  
RSpec.describe InventoryRepository do
    before(:each) do 
        reset_inventory_table
    end

    let(:repo) {InventoryRepository.new}

    describe '#all' do
        it 'lists all inventory objects' do
            inventory = repo.all
            expect(inventory.first.item).to eq 'printer'
            expect(inventory.last.item).to eq 'mouse'
            expect(inventory.length).to eq 2
        end
    end




end

