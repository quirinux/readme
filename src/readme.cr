#> ### ({{ filename }})[{{ filename }}]
#> readme file processor

require "crinja"

module Readme
  APPNAME = "readme"
  VERSION = "0.1.0"
  # PATTERN = "^(\\s|\\t)*#>" # BUG: this throws a weird memory leak error on libc
  PATTERN = "^#>"
  alias ARGTYPE = Symbol | String | Array(String) | Bool

  def Readme.run(args)
    App.new(args).run()
  end

  private class App
    @template : ARGTYPE
    @output : ARGTYPE
    @path : ARGTYPE
    @recursive : ARGTYPE
    @filetype : ARGTYPE

    def initialize(args)
      @template = args[:template]
      @output = args[:output]
      @path = args[:path]
      @recursive = args[:recursive]
      @filetype = args[:filetype]
      @filelist = [] of String
    end

    def run()
      list_files
      @filelist.each do |f|
        template = File.read_lines(f).
          map{ |m| m.strip }.
          select{ |s| s =~ /#{PATTERN}/ }.
          map do |m|
            if m.size >= 3
              m[3..]
            else
              " "
            end
        end
        render(f, template.join("\n")) if template.size > 0
      end
    end

    def list_files()
      #> TODO: add pattern filter
      #> TODO: add file type filter
      #> TODO: add user passed path instead of listing current
      #> TODO: add no-recursive option
      @filelist = Dir["**/*"].reject{ |f| File.directory?(f) }
    end

    def render(filename, content)
      #> TODO: add output file redirection
      puts Crinja.render(content, { filename: filename })
      puts ""
    end
  end
end
