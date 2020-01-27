require 'optparse'
require 'open3'
@opts = {
  cmd: './morse_code',
  build_cmd: 'cargo build --all --out-dir ./ --release -Z unstable-options'
}

def obfuscate_morse(morse)
  morse
    .gsub!(/(?<!-)(-)(?!-)/, 'A')
    .gsub!(/(?<!-)(--)(?!-)/, 'B')
    .gsub!(/(?<!-)(---)(?!-)/, 'C')
    .gsub!(/(?<!-)(----)(?!-)/, 'D')
    .gsub!(/(?<!-)(-----)(?!-)/, 'E')
    .gsub!(/(?<!\.)(\.)(?!\.)/, '1')
    .gsub!(/(?<!\.)(\.\.)(?!\.)/, '2')
    .gsub!(/(?<!\.)(\.\.\.)(?!\.)/, '3')
    .gsub!(/(?<!\.)(\.\.\.\.)(?!\.)/, '4')
    .gsub!(/(?<!\.)(\.\.\.\.\.)(?!\.)/, '5')
  morse
end

OptionParser.new do |opts|
  opts.banner = 'Morse Code Obfuscator: ruby obfuscate.rb [options]'

  opts.on(
    '-b',
    '--build',
    'Build the cargo project executable in ./ (required at least once).'
  ) do
    @opts[:build] = true
  end
  opts.on(
    '-i',
    '--input STRING',
    String,
    'Input string to be translated. Single line only.'
  ) do |input|
    @opts[:cmd] << " --input #{input}"
  end
  opts.on(
    '-f',
    '--infile FILE',
    'File to read for translation. Relative paths are accepted.'
  ) do |file|
    @opts[:cmd] << " --infile #{file}"
    @opts[:infile] = file
  end
  opts.on(
    '-o',
    '--outfile FILE',
    "Instruction to write to an output file as well as std out. 'default' writes to /translations."
  ) do |file|
    @opts[:cmd] << " --outfile #{file}"
    @opts[:outfile] = file
  end
  opts.on('-h', '--help', 'Print help info.') { puts opts; exit }
end.parse!

exec(@opts[:build_cmd]) if @opts[:build] || !File.exist?('morse_code')
stdout, status = Open3.capture2e(@opts[:cmd])

if status.exitstatus > 0
  puts '======================================================'
  puts 'An error occurred in the run, please check your input:'
  puts '======================================================'
  puts stdout
  exit status.exitstatus
end


if @opts[:outfile]
  morse_file = stdout.chomp.split(':')[1].strip
  morse, obs_file = if @opts[:infile]
                      [
                        File.open(morse_file, 'r').readlines,
                        morse_file.gsub(File.extname(morse_file), '.obs.txt')
                      ]
                    else
                      [stdout.chomp, "morse_#{Time.now.to_i}.obs.txt"]
                    end
  File.open(obs_file, 'w+') do |outfile|
    morse.each { |code| outfile.write obfuscate_morse(code) }
  end
  puts "#{stdout}Written to: #{obs_file}"
else
  stdout.split("\n").each { |morse| puts obfuscate_morse(morse) }
end

