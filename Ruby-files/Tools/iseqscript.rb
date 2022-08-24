require "zlib"

if ARGV.size != 1
  STDERR.puts("Usage: iseqscript scripts_dir")
  exit 1
end

scripts_dir = ARGV[0]

target_path = File.join("../Data/xScripts.rxdata")

scripts = []
data = File.read(File.join(scripts_dir, "Initializers/Intitizalize_ISEQ.rb")).rstrip.gsub("\n", "\r\n")

script = Array.new(3)
script[0] = 0
script[1] = "Main"
script[2] = Zlib.deflate(data)
scripts << script

File.open(target_path, "wb") { |f| f.write(Marshal.dump(scripts)) }
puts "#{target_path} written."
