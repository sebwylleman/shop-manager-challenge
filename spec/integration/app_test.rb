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

    def print_menu
        expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
        expect(io).to receive(:puts).with("Enter your choice: ").ordered
        expect(io).to receive(:puts).with("1 = list all shop items").ordered
        expect(io).to receive(:puts).with("2 = create a new item").ordered
        expect(io).to receive(:puts).with("3 = list all orders").ordered
        expect(io).to receive(:puts).with("4 = create a new order").ordered
        expect(io).to receive(:puts).with("5 = exit").ordered
    end

    it 'lists all inventory items' do
        print_menu
        expect(io).to receive(:gets).and_return("1").ordered
        expect(io).to receive(:puts).with("Here's a list of all shop inventory:").ordered
        expect(io).to receive(:puts).with("#1 printer - unit price: 60 - quantity: 8").ordered
        expect(io).to receive(:puts).with("#2 mouse - unit price: 30 - quantity: 12").ordered
        app.run
      end
      
end