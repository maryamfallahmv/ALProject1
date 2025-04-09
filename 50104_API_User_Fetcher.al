codeunit 50104 "API User Fetcher"
{
    procedure FetchDataFromAPI()
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonText: Text;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        UserId: Integer;
        UserName, UserEmail, UserUsername : Text;
        i: Integer;
    begin
        HttpClient.Get('https://jsonplaceholder.typicode.com/users', HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpResponseMessage.Content.ReadAs(JsonText);
            if JsonArray.ReadFrom(JsonText) then begin
                for i := 0 to JsonArray.Count() - 1 do begin
                    JsonArray.Get(i, JsonToken);
                    JsonObject := JsonToken.AsObject();

                    JsonObject.Get('id', JsonToken);
                    UserId := JsonToken.AsValue().AsInteger();

                    JsonObject.Get('name', JsonToken);
                    UserName := JsonToken.AsValue().AsText();

                    JsonObject.Get('email', JsonToken);
                    UserEmail := JsonToken.AsValue().AsText();

                    JsonObject.Get('username', JsonToken);
                    UserUsername := JsonToken.AsValue().AsText();
                end;
            end;
        end
        else
            Error('Failed to fetch data from the API');
    end;
}
