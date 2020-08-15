module ScriptHelper
    @@path : String = "test"
    
    def self.path
        @@path
    end
    
    def self.path=(value)
        @@path = value
    end
end

# TODO: Scripting module methods