#> readme file processor
# > this is the app file

require "crinja"
require "ecr"
require "shard"

module Readme
  APPNAME = Shard.name
  VERSION = Shard.version
  PATTERN = /^(\\s|\\t)*(#|\/\/)\s?>/ # BUG: this throws a weird memory leak error on libc
  # PATTERN = "^#>"
  alias ARGTYPE = Symbol | String | Array(String) | Bool
  DEFAULT_TEMPLATE = ECR.render("templates/default.ecr")

  def Readme.run(args)
    App.new(args).run
  end

  @[Crinja::Attributes(expose: [filename, content])]
  private class ContextItem
    include Crinja::Object::Auto
    property filename : String
    property content : String

    def initialize(filename)
      @filename = filename
      @content = load_template(filename)
    end

    def load_template(filename)
      File.read_lines(filename)
        .map { |m| m.strip }
        .select { |s| s =~ /#{PATTERN}/ }
        .map do |m|
          size = 1
          if md = m.match(PATTERN)
            size += md[0].size
          end
          if m.size >= size
            m[size..]
          else
            "\n"
          end
        end.join("\n")
    end
  end

  private class App
    @template : ARGTYPE
    @output : ARGTYPE
    @path : ARGTYPE
    @recursive : ARGTYPE
    @filetype : ARGTYPE
    @context : Array(ContextItem)

    def initialize(args)
      @template = args[:template]
      @output = args[:output]
      @path = args[:path]
      @recursive = args[:recursive]
      @filetype = args[:filetype]
      @filelist = [] of String
      @context = Array(ContextItem).new
    end

    def run
      context_setup
      list_files.each do |f|
        context_add(f)
      end
      render
    end

    def context_setup
      case @template
      when Symbol
        @template = DEFAULT_TEMPLATE
      when String
        @template = File.read_lines(@template.to_s).join("\n")
      else
        raise "it could not be determined the context, this is somehting else => #{@template}, #{@template.class}"
      end
    rescue fex : File::NotFoundError
      puts "File not found #{@template}"
      exit 1
    end

    def context_add(filename)
      @context << ContextItem.new(filename)
    end

    def list_files
      #> - TODO: add pattern filter
      #> - TODO: add file type filter
      #> - TODO: add user passed path instead of listing current
      #> - TODO: add no-recursive option
      @filelist = Dir["**/*"].reject { |f| File.directory?(f) }
    end

    def render
      config = Crinja::Config.new
      config.keep_trailing_newline = true
      config.trim_blocks = true
      env = Crinja.new(config: config)
      processed = env.from_string(@template.to_s).render({files: @context})
      show processed
    rescue ex : Crinja::TemplateNotFoundError
      puts ex
    rescue ex : Crinja::FeatureLibrary::UnknownFeatureError
      puts ex
    end

    def show(processed)
      puts processed
    end
  end
end
