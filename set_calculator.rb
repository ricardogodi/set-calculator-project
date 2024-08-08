# Author: Ricardo Gonzalez
# CS 474
# Professor: Ugo Buy
# Project #1

################################################################################
# Set Calculator
#
# Description:
# This program provides a command-line interface for a Set Calculator that
# operates on three sets named X, Y, and Z. Users can perform various operations
# on these sets, including initialization with values, inserting values,
# rotating set contents, switching set contents, calculating the union or
# intersection of two sets, and applying lambda functions to set elements.
#
# The sets are implemented as binary trees.
#
# ##############################################################################

# MySet class represents a set data structure implemented using a binary tree.
class MySet
  # Making the attribute accessor for 'root' private ensures that
  # external entities cannot directly manipulate the root node of the set.
  private
  attr_accessor :root

  public

  # Initialize a new instance of MySet.
  # By default, it initializes without a root node,
  # but it can accept a root node if provided.
  def initialize(root_node = nil)
    @root = root_node
  end

  # Public method to add a value to the set.
  # If the value already exists, it ignores (avoids duplicates).
  # It uses binary tree logic (non-balancing) to decide where to place the new value.
  def add(value)
    @root = insert(@root, value)
  end

  private

  # Recursive helper method to insert a new value into the binary tree.
  # It is used by the public 'add' method.
  def insert(current_node, value)
    # If the current node is nil, create a new node with the value and return it.
    return Node.new(value) if current_node.nil?

    # If the value is less than the data of the current node,
    # insert it to the left subtree.
    if value < current_node.data
      current_node.left = insert(current_node.left, value)

      # If the value is greater than the data of the current node,
      # insert it to the right subtree.
    elsif value > current_node.data
      current_node.right = insert(current_node.right, value)

    end     # If the value is equal to the current node's data, do nothing,
    # effectively ignoring duplicates.

    current_node
  end

  public

  # Public method to check if a value exists in the set.
  def contains?(value)
    find(@root, value)
  end

  # Recursive helper method to search for a value in the binary tree.
  def find(current_node, value)
    # If the current node is nil, return false, indicating the value was not found.
    return false if current_node.nil?

    # If the value matches the current node's data, return true.
    if value == current_node.data
      true
      # If the value is less than the current node's data, search in the left subtree.
    elsif value < current_node.data
      find(current_node.left, value)
      # If the value is greater, search in the right subtree.
    else
      find(current_node.right, value)
    end
  end

  # Method to clear the set, removing all its elements.
  def clear()
    @root = nil
  end

  public

  # Public method to print the set's elements.
  # This method initiates the process to print elements in order.
  def print_elements
    # If the set is empty, print "null".
    if @root.nil?
      puts "null"
    else
      # If the set is not empty, print its elements in order.
      print_in_order(@root)
      # After printing all elements, move to the next line.
      puts
    end
  end

  private

  # Recursive method to perform in-order traversal of the binary tree.
  # It prints each element of the set, separated by a space.
  def print_in_order(node)
    return if node.nil?  # Base case: If node is nil, just return.

    print_in_order(node.left)  # Recursively traverse the left subtree.
    print node.data, " "  # Print the current node's data followed by a space.
    print_in_order(node.right)  # Recursively traverse the right subtree.
  end

  public

  # Public method that allows external code to iterate over each element in the set.
  # This uses in-order traversal to ensure elements are accessed in order.
  def each(&block)
    traverse_in_order(@root, &block)
  end

  private

  # Recursive method for in-order traversal of the tree.
  # Instead of printing the data (like in `print_in_order`), this method yields
  # each element to a provided block of code.
  def traverse_in_order(node, &block)
    return if node.nil?  # Base case: If node is nil, just return.

    traverse_in_order(node.left, &block)  # Recursively traverse the left subtree.
    yield node.data  # Yield the current node's data to the provided block.
    traverse_in_order(node.right, &block)  # Recursively traverse the right subtree.
  end

  public

  # Creates and returns a new MySet instance that's a deep copy of the current set.
  # This ensures that changes to the new set don't affect the original set, and vice versa.
  def deep_copy
    MySet.new(_copy_node(@root))
  end

  private

  # Recursive helper method to create a deep copy of a node and its subtrees.
  def _copy_node(node)
    return nil if node.nil?  # Base case: If node is nil, return nil.

    new_node = Node.new(node.data)  # Create a new node with the same data.
    new_node.left = _copy_node(node.left)  # Recursively copy the left subtree.
    new_node.right = _copy_node(node.right)  # Recursively copy the right subtree.
    new_node  # Return the new node.
  end

  public

  # Store the union of the current set with another set (passed as an argument).
  def union_with!(other_set)
    other_set.each do |element|
      add(element)
    end
    self
  end

  # Updates the current set with the intersection of itself and another set.
  def intersect_with!(other_set)
    # First, make a deep copy of the current set
    temp_copy = deep_copy

    # Clear current set
    clear()

    temp_copy.each do |element|
      add(element) if other_set.contains?(element)
    end
  end

  # Apply a lambda function to each element of the set and display the results.
  def apply_lambda!(arg)
    # Convert string representation of lambda to an actual lambda function
    lambda_func = eval("lambda #{arg}")

    print "Result of applying the lambda expression: #{arg}: "
    each do |element|
      # Apply the lambda function to the element
      modified_value = lambda_func.call(element)
      print "#{modified_value} "
    end
    puts # Move to the next line after displaying all results
  end
end

#########################################################################
# Node class represents an individual node in the binary tree.
# Each node has data, a left child, and a right child.
class Node
  attr_accessor :data, :left, :right

  # Initializes a new Node instance with the provided data.
  # By default, the left and right children are set to nil.
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

##########################################################################
# Print the main menu for the Set Calculator program.
def print_menu
  puts "----------------- Set Calculator Menu -----------------"
  puts "1. X values    - Initialize set X with comma-separated values."
  puts "2. Y values    - Initialize set Y with comma-separated values."
  puts "3. Z values    - Initialize set Z with comma-separated values."
  puts "4. a i         - Insert numeric argument i into set X."
  puts "5. r           - Rotate contents of sets (Y -> X, Z -> Y, X -> Z)."
  puts "6. s           - Switch contents of sets X and Y."
  puts "7. u           - Store union of sets X and Y into X."
  puts "8. i           - Store intersection of sets X and Y into X."
  puts "9. c           - Deep copy set X into set Y."
  puts "10. l aString  - Apply lambda expression to each element of set X. EXAMPLE: l {|x| x * 2}"
  puts "11. q          - Quit the program."
  puts "-------------------------------------------------------"
  puts "Enter your command:"
end

# Print the current state of all sets: X, Y, and Z.
def print_all_sets(x, y, z)
  # Display each set with its name.
  print "X: "
  x.print_elements
  print "Y: "
  y.print_elements
  print "Z: "
  z.print_elements
  puts
end

# Populate a set with values from a comma-separated string.
def initialize_set_from_values(set, values_str)
  values_array = values_str.split(",").map(&:to_i) # Split the input string at commas, and convert each segment to an integer.
  values_array.each do |value|
    set.add(value)
  end
end

# Rotate the contents of the sets.
def rotate_sets(x, y, z)
  temp = z
  z = y
  y = x
  x = temp
  [x, y, z]
end

# Switch the contents of sets X and Y.
def switch_x_y(x, y)
  temp = y
  y = x
  x = temp
  [x, y]
end

#####################################################################
# The main driver function for the Set Calculator program
def main
  # Initialize three sets: X, Y, and Z
  x = MySet.new
  y = MySet.new
  z = MySet.new

  # Display the main menu
  print_menu

  # Enter the command-processing loop
  loop do
    # Get user input for the command
    command = gets.chomp
    # Split the command into the main command and its argument (if any)
    command, arg = command.split(' ', 2)

    # Process the command
    case command

    when "X"  # Matches any command starting with "X " and captures the rest
      initialize_set_from_values(x, arg)
      print_all_sets(x,y,z)

    when "Y"  # Matches any command starting with "Y " and captures the rest
      initialize_set_from_values(y, arg)
      print_all_sets(x,y,z)

    when "Z"  # Matches any command starting with "Z " and captures the rest
      initialize_set_from_values(z, arg)
      print_all_sets(x,y,z)

    when "a"
      # Insert a number into set X
      i = arg.to_i
      x.add(i)
      print_all_sets(x, y, z)

    when "r"
      # Rotate the sets' content
      x, y, z = rotate_sets(x, y, z)
      print_all_sets(x, y, z)

    when "s"
      # Switch the content of sets X and Y
      x, y = switch_x_y(x, y)
      print_all_sets(x, y, z)

    when "u"
      # Store the union of sets X and Y into X
      #x = x_y_union(x, y)
      x.union_with!(y)
      print_all_sets(x, y, z)

    when "i"
      # Store the intersection of sets X and Y into X
      #x = x_y_intersection(x, y)
      x.intersect_with!(y)
      print_all_sets(x, y, z)

    when "c"
      # Deep copy set X into set Y
      y = x.deep_copy
      print_all_sets(x, y, z)

    when "l"
      # Apply a lambda expression to each element of set X
      #apply_lambda(x, arg)   # User can try with the command: l {|x| x * 2}
      x.apply_lambda!(arg)
      print_all_sets(x, y, z)

    when "p"
      # Print the content of all sets
      print_all_sets(x, y, z)

    when "q"
      # Exit the program
      puts "Exiting..."
      break

    else
      # Handle any unrecognized command
      puts "Invalid command"
    end
  end
end

# If this script is being run directly, call the main function
if __FILE__ == $0
  main
end