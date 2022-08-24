require "zlib"

File.open("Data/xIseq.rxdata", "rb") do |f|
  two = Marshal.load(f)
  puts two # :)
  iseqs = []
  zlibed_iseqs = Marshal.load(f)
  zlibed_iseqs.each { |zlibed_iseq| iseqs << Zlib::Inflate.inflate(zlibed_iseq) }

  iseqs.each do |iseq|
    RubyVM::InstructionSequence.load_from_binary(iseq).eval
  end
end
