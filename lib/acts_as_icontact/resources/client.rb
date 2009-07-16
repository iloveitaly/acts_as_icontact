module ActsAsIcontact
  # The nested Client Folder resource from iContact.  Currently only supports retrieval -- and is 
  # highly targeted toward the _first_ client folder, since that seems to be the dominant use case.
  class Client < Resource
    # Returns an array of client folders associated with this username.  (Probably only one.)
    def self.all
      response = ActsAsIcontact.account['c'].get
      parsed = JSON.parse(response)
      parsed["clientfolders"].collect{|a| self.new(a)}
    end
    
    # Returns the first account associated with this username.
    def self.first
      all.first
    end
  end
  
  # The clientFolderId retrieved from iContact.  Can also be set manually for performance 
  # optimization, but remembers it so that it won't be pulled more than once anyway.
  def self.client_id
    @client_id ||= Client.first.clientFolderId.to_i
  end
  
  # Manually sets the clientFolderId used in subsequent calls.  Setting this in your 
  # initializer will save at least one unnecessary request to the iContact server.
  def self.client_id=(val)
    @client_id = val
  end
  
  # RestClient subresource scoped to the specific account ID.  Most other iContact calls will derive
  # from this one.
  def self.client
    @client ||= account["c/#{client_id}"]
  end
  
  # Clears the account resource from memory.  Called by reset_connection! since the only likely reason
  # to do this is connecting as a different user.
  def self.reset_client!
    @client = nil
  end
end