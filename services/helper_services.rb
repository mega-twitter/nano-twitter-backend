require 'json'
require_relative '../models/user.rb'

def make_json(status, code, message, data = {})
    {
        status: status,
        body: {
            code: code,
            message: message,
            data: data.as_json
        }
    }
  end