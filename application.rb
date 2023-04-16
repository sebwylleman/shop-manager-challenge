require_relative './lib/order_repository'
require_relative './lib/inventory_repository'

class Application
  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the orderRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(shop_manager, io, order_repository, inventory_repository)
    DatabaseConnection.connect(shop_manager)
    @io = io
    @order_repository = order_repository
    @inventory_repository = inventory_repository
  end

  def print_menu
    @io.puts "Welcome to the shop management program!"
    @io.puts "Enter your choice: "
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts "5 = exit"
  end

  def selection(choice)
    case choice
    when '1'
      print_inventory
    when '2'
      create_item
    when '3'
      list_orders
    when '4'
      create_order
    when '5'
      exit
    else
      @io.puts "I don't know what you meant, try again"
    end
  end

  def run
    loop do
      print_menu
      selection(@io.gets.chomp)
      @io.puts '------------------------------------------------'
    end
  end

  def print_inventory
    @io.puts "Here's a list of all shop inventory:"
    i = 1
    @inventory_repository.all.each do |entry|
      @io.puts "##{i} #{entry.item} - unit price: #{entry.price} - quantity: #{entry.quantity}"
      i += 1
    end
  end

  def create_item
    new_item = Inventory.new
    @io.puts 'Enter item name: '
    name = @io.gets.chomp
    new_item.item = name
    @io.puts 'Enter price as an integer: '
    price = @io.gets.chomp
    new_item.price = price
    @io.puts 'Enter item quantity as an integer: '
    quantity = @io.gets.chomp
    new_item.quantity = quantity
    @inventory_repository.create(new_item)
    @io.puts 'Item added'
  end

  def list_orders
    @io.puts 'Orders: '
    orders = OrderRepository.new.all
    orders.each do |order|
      @io.puts "customer: #{order.customer} - date: #{order.date}"
    end
  end

  def create_order
    new_order = Order.new
    @io.puts 'Enter customer name:'
    customer = @io.gets.chomp
    new_order.customer = customer
    @io.puts 'Enter date of order:'
    new_order.date = @io.gets.chomp
    OrderRepository.new.create(new_order)
    @io.puts 'Order created'
  end
end
# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    OrderRepository.new,
    InventoryRepository.new
  )
  app.run
end