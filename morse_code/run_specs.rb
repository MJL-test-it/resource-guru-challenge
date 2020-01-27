require 'optparse'
require 'open3'
@opts = { cmd: 'rspec --tty --color ' }

OptionParser.new do |opts|
  opts.banner = 'Spec Runner Usage: ruby run_specs.rb [options]'

  opts.on(
    '-b',
    '--build',
    'Build the cargo project executable in spec/integration (required at least once for specs to run).'
  ) do
    @opts[:build] = true
  end
  opts.on(
    '-t',
    '--target FILE,FILE,FILE...',
    Array,
    'Specify a spec to run.'
  ) do |files|
    @opts[:cmd] << files.join(' ')
  end
  opts.on(
      "-l",
      "--spec-list",
      "Outputs a list of integration specs that can be targetted and exits."
  ) do
    puts 'Available specs:'
    puts "\t#{Dir.glob('spec/integration/*').grep_v(/morse_code/).join("\n\t")}"
    exit
  end
  opts.on('-h', '--help', 'Print help info.') { puts opts; exit }
end.parse!

if @opts[:build]
  `cargo build --all --out-dir spec/integration --release -Z unstable-options`
end

stdout, _status = Open3.capture2e(@opts[:cmd])
puts
puts @opts[:cmd]
puts
puts stdout
