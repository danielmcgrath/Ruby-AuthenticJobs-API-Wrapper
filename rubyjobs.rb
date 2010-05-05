require 'open-uri'
require 'json'
require 'md5'

class RubyJobs
    def initialize(api_key)
        @domain = "http://www.authenticjobs.com/api/?api_key=" + api_key
        @apikey = api_key
    end
    
    def parseJSON(apicall)
        sortParams = apicall.split("&").sort!.join("&")
        infoString = "?api_key=" + @apikey + sortParams
        signature = MD5.new(infoString.gsub(/[=?&]/, '')).to_s
        finalCall = @domain + apicall + "&api_sig=" + signature
        response = open(finalCall).read()
        return JSON.parse(response)
    end
        
    def searchJobs(options = {})
        parameters = {
            :category => nil,
            :company  => nil,
            :format   => "json",
            :keywords => nil,
            :location => nil,
            :method   => "aj.jobs.search",
            :page     => nil,
            :perpage  => nil,
            :sort     => nil,
            :type     => nil
        }.merge options
        
        apicall = ""
        
        parameters.each {|key, value|
            if !value.nil?
                apicall += "&#{key}=#{value}"
            end
        }
        
        return parseJSON(apicall)
    end
    
    def getCompanies 
        return parseJSON("&format=json&method=aj.jobs.getcompanies")
    end
    
    def getTypes
        return parseJSON("&format=json&method=aj.types.getlist")
    end
    
    def getCategories
        return parseJSON("&format=json&method=aj.categories.getlist")
    end
    
    def getLocations
        return parseJSON("&format=json&method=aj.jobs.getlocations")
    end
end