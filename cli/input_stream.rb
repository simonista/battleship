module CLI
  class InputStream
    def self.default
      if ARGV.empty?
        new STDIN, false
      else
        filename = ARGV.shift
        new File.open(filename), true
      end
    end

    def initialize(stream, echo)
      @stream = stream
      @echo = echo
    end

    def readline
      return nil if @stream.eof?
      value = @stream.gets.chomp
      puts value if @echo
      value
    end
  end
end
