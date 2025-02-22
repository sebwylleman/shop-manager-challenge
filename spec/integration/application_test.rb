require_relative '../../application.rb'

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

  it 'prints the menu' do
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("Enter your choice: ").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:puts).with("5 = exit").ordered
    app.print_menu
  end
  
  it 'performs tasks based on user input' do
    expect(app).to receive(:print_inventory)
    app.selection('1')

    expect(app).to receive(:create_item)
    app.selection('2')

    expect(app).to receive(:list_orders)
    app.selection('3')

    expect(app).to receive(:create_order)
    app.selection('4')

    expect(app).to receive(:exit)
    app.selection('5')
  end


  
  it 'lists all inventory items' do
    expect(io).to receive(:puts).with("Here's a list of all shop inventory:").ordered
    expect(io).to receive(:puts).with("#1 printer - unit price: 60 - quantity: 8").ordered
    expect(io).to receive(:puts).with("#2 mouse - unit price: 30 - quantity: 12").ordered
    app.print_inventory
  end
  
  it 'creates a new inventory item' do
    expect(io).to receive(:puts).with('Enter item name:').ordered
    expect(io).to receive(:gets).and_return('clock').ordered
    expect(io).to receive(:puts).with('Enter price:').ordered
    expect(io).to receive(:gets).and_return('23').ordered
    expect(io).to receive(:puts).with('Enter item quantity:').ordered
    expect(io).to receive(:gets).and_return('8').ordered
    expect(io).to receive(:puts).with('Item added').ordered
    app.create_item
  end
      
  it 'lists all orders' do
    expect(io).to receive(:puts).with('Orders:').ordered
    expect(io).to receive(:puts).with("customer: John Smith - date: 2023-04-14").ordered
    expect(io).to receive(:puts).with("customer: Tim Cook - date: 2023-05-22").ordered
    app.list_orders
  end

  it 'creates a new inventory item' do
    expect(io).to receive(:puts).with('Enter customer name:').ordered
    expect(io).to receive(:gets).and_return('Ben Hamilton').ordered
    expect(io).to receive(:puts).with('Enter date of order:').ordered
    expect(io).to receive(:gets).and_return('2023-11-29').ordered
    expect(io).to receive(:puts).with('Order created').ordered
    app.create_order
  end
end