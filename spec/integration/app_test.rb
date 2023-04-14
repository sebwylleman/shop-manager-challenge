require_relative '../../app.rb'

def reset_all_tables
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe Application do

    let(:order_repository) {OrderRepository.new}
    let(:inventory_repository) {InventoryRepository.new}
    let(:io) {double(:io)}
    let(:app) {Application.new('shop_manager_test', io, order_repository, inventory_repository)}

    before(:each) do
        reset_all_tables
    end

    it 'lists all inventory items' do
        DatabaseConnection.connect('shop_manager_test')
        expect(io).to receive(:gets).and_return("1").ordered
        expect(io).to receive(:puts).with("Here's a list of all shop items:").ordered
        expect(io).to receive(:puts).with("#1 printer - unit price: 60 - Quantity: 8")
        expect(io).to receive(:puts).with("#2 mouse - unit price: 30 - Quantity: 12")
    end
end