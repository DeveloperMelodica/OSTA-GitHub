#!/usr/bin/ruby
require "zlib"

def usage
  STDERR.puts "usage: dbgscript.rb scripts_dir game_dir [x]"
  exit 1
end

usage if ARGV.length < 2
scripts_dir = ARGV[0]
game_dir = ARGV[1]

# Determine version of game engine
game_data_dir = File.join(game_dir, "Data")
unless Dir.exist? game_data_dir
  STDERR.puts "error: #{game_dir} does not have a Data subdirectory"
  exit 1
end

target_path = nil
Dir.entries(game_data_dir).each do |e|
  ext = File.extname(e)
  if ext =~ /\.r[xv]data2?/
    target_path = File.join(game_data_dir, "xScripts" + ext)
    break
  end
end

unless target_path
  STDERR.puts "warning: could not determine game engine version, assuming XP"
  target_path = File.join(game_data_dir, "xScripts.rxdata")
end

# Write scripts
scripts = []
name = "Initializers/Initialize_RDEBUG"
data = File.read(File.join(scripts_dir, name + ".rb")).rstrip.gsub("\n", "\r\n")

script = Array.new(3)
script[0] = 0
script[1] = "Main"
script[2] = Zlib.deflate(data)
scripts << script

File.open(target_path, "wb") { |f| f.write(Marshal.dump(scripts)) }
puts "#{target_path} written."
