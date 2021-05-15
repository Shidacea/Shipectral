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

  def self.load(filename : String)
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

  def self.load_recursively(path : String)
    full_path = ScriptHelper.path + "/" + path
    ScriptHelper.load_absolute_path(full_path)
  end

  def self.debug?
    true
    # TODO
  end

  def self.version
    "0.0.1"
    # TODO
  end
end
