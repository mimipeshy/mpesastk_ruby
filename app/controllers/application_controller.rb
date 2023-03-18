class ApplicationController < ActionController::API
    private
    #Gives you a time bound access token to call allowed APIs in the sandbox.
    def generate_access_token_request
        @url= "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
        @consumer_key=  ENV['MPESA_CONSUMER_KEY']
        @consumer_secret= ENV['MPESA_CONSUMER_SECRET']
        @userpass = Base64::strict_encode64("#{@consumer_key}:#{@consumer_secret}")
        headers ={
            Authorization : "Bearer #{@userpass}"
        }
        res = RestClient::Request.execute(url: @url, method: :get, headers:{
            Authorization: "Basic #{@userpass}"
        })
        res
    end

    #Used to check if generate_acces_token_request is 
    #successful or not then it reads the responses and 
    #extracts the access token from the response and 
    #saves it to the database.
    def get_access_token
        res= generate_acces_token_request()
        if res.code != 200
            r= generate_acces_token_request()
            if res.code != 200
                raise MpesaError('Unable to generate access token')
            end
        end
        body= JSON.parse(res, {symbolize_names: true})
        token= body[:access_token]
        AccessToken.destroy_all()
        AccessToken.create!(token: token)
    end
end
