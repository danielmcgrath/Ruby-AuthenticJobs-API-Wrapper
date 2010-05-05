require 'open-uri'
require 'json'

class RubyJobs
    def initialize(api_key)
        @domain = "http://www.authenticjobs.com/api/?api_key=" + api_key
    end
    
    def parseJSON(apicall)
        response = open(apicall).read()
        return JSON.parse(response)
    end
        
    def searchJobs(options = {})
        apicall = @domain
        
        parameters = {
            :category => nil,
            :company => nil,
            :format => "json",
            :keywords => nil,
            :location => nil,
            :method => "aj.jobs.search",
            :page => nil,
            :perpage => nil,
            :sort => nil,
            :type => nil
        }.merge options
        
        parameters.each {|key, value|
            if !value.nil?
                apicall += "&#{key}=#{value}"
            end
        }
        
        return parseJSON(apicall)
    end
    
    def getCompanies 
        apicall = @domain + "&format=json&method=aj.jobs.getcompanies"
        return parseJSON(apicall)
    end
    
    def getTypes
        apicall = @domain + "&format=json&method=aj.jobs.getlist"
        return parseJSON(apicall)
    end
    
    def getCategories
        apicall = @domain + "&format=json&method=sj.categories.getList"
        return parseJSON(apicall)
    end
    
    def getLocations
        apicall = @domain + "&format=json&method=aj.jobs.getlocations"
        return parseJSON(apicall)
    end
end