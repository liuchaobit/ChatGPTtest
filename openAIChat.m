 function [result,tokens] = openAIChat(content)
% %openAIChat Call openAI REST API for chat completions
% %   Detailed explanation goes here
tic
import matlab.net.*
import matlab.net.http.*
api_endpoint = "https://ngedlktfticp.cloud.sealos.io/v1/chat/completions";
% Define the API key from https://beta.openai.com/account/api-keys
api_key = "sk-YHqx2Kh2HPiMG96I487e4dCcE766470c91Dd6fF13dD750A8";
data = jsondecode('{"model":"gpt-3.5-turbo","messages":[{"role":"system","content":"You are a helpful assistant."},{"role":"user","content":"What is my birthday?"}]}');
data.messages(2).content = content;
% Define the headers for the API request
headers = matlab.net.http.HeaderField('Content-Type', 'application/json');
headers(2) = matlab.net.http.HeaderField('Authorization', 'Bearer ' + api_key);
% Define the request message
request = matlab.net.http.RequestMessage('post',headers,data);
% Send the request and store the response
options = matlab.net.http.HTTPOptions;
options.CertificateFilename=('');
options.ConnectTimeout =100; 
response = send(request, URI(api_endpoint),options);
% Extract the response text
result = response.Body.Data.choices.message.content;
tokens = response.Body.Data.usage;
toc
%disp(result);
end