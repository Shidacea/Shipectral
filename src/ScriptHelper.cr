@[Anyolite::RenameModule("Script")]
module ScriptHelper
  @@path : String = "test"

  def self.path
    @@path
  end

  def self.path=(value : String)
    @@path = value
  end

  @[Anyolite::Exclude]
  def self.load_absolute_file(filename : String)
    rb = Anyolite::RbRefTable.get_current_interpreter
    rb.load_script_from_file(filename)
  end

  @[Anyolite::WrapWithoutKeywords]
  @[Anyolite::ReturnNil]
  def self.load(filename : String)
    puts "Loading #{filename}..."
    ScriptHelper.load_absolute_file(ScriptHelper.path + "/" + filename)
  end

  @[Anyolite::Exclude]
  def self.load_absolute_path(path : String)
    puts "Loading #{path}"
    Dir.each(path) do |file|
      puts "Trying #{file}"
      unless file.starts_with?(".")
        filename = path + "/" + file
        if File.directory?(filename)
          ScriptHelper.load_absolute_path(filename)
        elsif file.ends_with?(".rb")
          ScriptHelper.load_absolute_file(filename)
        end
      end
    end
  end

  @[Anyolite::WrapWithoutKeywords]
  @[Anyolite::ReturnNil]
  def self.load_recursively(path : String)
    puts "Loading #{path} recursively..."
    full_path = ScriptHelper.path + "/" + path
    ScriptHelper.load_absolute_path(full_path)
  end

  def self.debug?
    {% if flag? :debug %}
      true
    {% else %}
      false
    {% end %}
  end

  # TODO: These will become relevant for later Shidacea versions

  def enable_crystal_gc
    GC.enable
  end

  def disable_crystal_gc
    GC.disable
  end

  def run_crystal_gc
    GC.collect
  end

  def self.version
    SHIPECTRAL_VERSION
    # TODO
  end
end
