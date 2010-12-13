require 'path'

file = ARGV[0]
num_ants = ARGV[1].to_i
num_iterations = ARGV[2].to_i

path = Path.new("test_files/" + file, num_ants, num_iterations)
path.search
