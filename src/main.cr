#> ### ({{ filename }})[{{ filename }}]
#> this is the project main file, where all the magic begins

require "option_parser"
require "./readme"

# args = Hash(Symbol, (Symbol | String | Array(String) | Bool)){
args = Hash(Symbol, Readme::ARGTYPE){
  :template => :default,
  :output => :stdout,
  :path => :current,
  :recursive => true,
  :filetype => :any,
  #> TODO: it'd be nice to have an exclude path/files flag
  # :exclude => [] of String,
}

OptionParser.parse do |parser|
  parser.banner = "Usage: #{Readme::APPNAME} [arguments]"
  parser.on("-t FILE", "--template=FILE", "ECR template file, [default: #{args[:template]}]") { |t| args[:template] = t }
  parser.on("-o FILE", "--output=FILE", "Specifies output file, [default: #{args[:output]}]") { |o| args[:output] = o }
  # parser.on("-e PATH", "--exclude=PATH", "Exclude path or file, accepts multiple occurrences, [default: #{args[:exlucde]}]") { |e| args[:exclude] << e }
  parser.on("--no-recursive", "Disable recursive file lookup, [default: #{!args[:recursive]}]") { args[:recursive] = false }
  parser.on("--file-type", "File type extension to filter, [default: #{args[:filetype]}]") { |f| args[:filetyep] = f }
  parser.on("-v", "--version", "Show version") do
    puts Readme::VERSION
    exit
  end
  parser.on("-h", "--help", "Show this help") do
    puts parser
    puts "For further help with templates please refer to: https://github.com/straight-shoota/crinja"
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts "Check --help for further support"
    exit(1)
  end
end

args[:path] = ARGV if ARGV.size > 0
Readme.run(args)
