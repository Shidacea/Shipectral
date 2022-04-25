module SPT
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  module Script
    @@path : String = ((exec_path = Process.executable_path) ? File.dirname(exec_path) : ".")

    def self.path
      @@path
    end

    def self.path=(value : String)
      @@path = value
    end

    def self.get_full_filename(filename : String)
      File.join(@@path, filename)
    end

    @[Anyolite::Exclude]
    def self.load_absolute_file(filename : String)
      rb = Anyolite::RbRefTable.get_current_interpreter
      rb.load_script_from_file(filename)
    end

    @[Anyolite::ReturnNil]
    def self.load(filename : String)
      puts "Loading #{filename}..."
      Script.load_absolute_file(Script.get_full_filename(filename))
    end

    @[Anyolite::Exclude]
    def self.load_absolute_path(path : String)
      puts "Loading #{path}"
      Dir.each(path) do |file|
        puts "Trying #{file}"
        unless file.starts_with?(".")
          filename = path + "/" + file
          if File.directory?(filename)
            Script.load_absolute_path(filename)
          elsif file.ends_with?(".rb")
            Script.load_absolute_file(filename)
          end
        end
      end
    end

    @[Anyolite::ReturnNil]
    def self.load_recursively(path : String)
      puts "Loading #{path} recursively..."
      full_path = Script.path + "/" + path
      Script.load_absolute_path(full_path)
    end

    def self.debug?
      {% if flag? :debug %}
        true
      {% else %}
        false
      {% end %}
    end

    # TODO: These will become relevant for later Shidacea versions

    def self.enable_crystal_gc
      GC.enable
    end

    def self.disable_crystal_gc
      GC.disable
    end

    def self.run_crystal_gc
      GC.collect
    end

    def self.version
      SHIPECTRAL_VERSION
      # TODO
    end
  end
end