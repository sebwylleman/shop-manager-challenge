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
    puts "Welcome to the shop management program!"
    puts # blank line for better readability
    puts "What do you want to do?"
    puts "1 = list all shop items"
    puts "2 = create a new item"
    puts "3 = list all orders"
    puts "4 = create a new order"
    puts "5 = exit"
  end

  def process(selection)
     # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    puts "Enter your choice: "
    case selection
    when '1'
      puts "Here's a list of all shop items:"
    when '2'

    when '3'

    when '4'

    when '5'
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end

  def run
    loop do
      print_menu
      process(STDIN.gets.chomp)
    end

    puts 'Welcome to the shop management program!'
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