# yield allows a block of code outside the method to be called with the method
# yield does not care about number of arguments, passes 'nil' if no arg when arg expected
# yield does care if there is no block provided with method call, produces error
# use block control using block_given? to provide alternative if no block provided
def hello
  if block_given?
    yield('Ben')
  else
    puts 'not a single block was given that day'
  end
end

hello { |var| puts "hello there #{var}!"}
puts hello

# yield lets you be more efficient. Only need to define method once and call different blocks for different output
# e.g. instead of writing two different methods, just define two different blocks with the method call
@transactions = [10, -15, 25, 30, -24, -70, 999]
def statement
  array = []
  @transactions.each do |value|
    array << yield(value)
  end
  print "#{array}\n"
end

statement { |value| value * 2}
statement { |value| value / 2}

# iterate over hash and execute the block called with the method
hash = {a: 'hello', b: 'you', c: 'flower'}
def print_hash(hash)
  hash.each do |k, v|
    yield k, v
  end
end

print_hash(hash) { |k, v| puts "key #{k} has value #{v}!"}

# a proc allows you to assign a block to an object. Create with 'proc' or 'Proc.new'
# block can be called multiple ways, recommended to use .call
# like yield, proc does not care about number of arguments
a_proc = proc {|a| puts "the argument is #{a}."}
puts a_proc.call('squelch')
puts a_proc.call

# lambda allows you to assign a block to a variable, and is a type of proc
# lambda will produce an error if #args not as expected, unless default val provided
a_lambda = ->(a) { puts "the argument is #{a}."}
puts a_lambda.call('salmon')
# puts a_lambda.call

# procs and lambdas both allow default values
proc_two = proc { |name = 'Taboo'| puts "Proc says I like the the Netflix show #{name}"}
proc_two.call('Stranger Things')
proc_two.call

lambda_two = ->(name = 'Taboo') {puts "Lambda says I like the the Netflix show #{name}"}
lambda_two.call('Stranger Things')
lambda_two.call

# procs and lambdas can both be passed as arguments to a method
def netflix(block1, block2)
  print block1.call
  print block2.call('Top Boy')
end

netflix(proc_two, lambda_two)

# capturing blocks is a lot like using yield 
# this can be used instead of 'yield' and is clearly visual in the defined arguments
# whereas 'yield' is contained in the method body and must be read through to see
# the '&' calls the #to_proc method, converts the block to a proc, allowing .call method in the method body
def say_something(&something_block)
  something_block.call
end

say_something { puts 'is this enough?' }

# you can run the reverse, where '&' will convert a proc to a block if used in the method instead
# the '&' allows you to pass the block, without it you would get an argument error
def say_another
  yield
end

proc_three = proc { puts 'how about this?' }

say_another(&proc_three)