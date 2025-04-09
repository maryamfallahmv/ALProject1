codeunit 50105 "API Post Fetcher"
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
        PostRecord: Record "Temporary Post";
        UserId, Id : Integer;
        Title, Body : Text;
        i: Integer;
    begin
        HttpClient.Get('https://jsonplaceholder.typicode.com/posts', HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpResponseMessage.Content.ReadAs(JsonText);
            if JsonArray.ReadFrom(JsonText) then begin
                for i := 0 to JsonArray.Count() - 1 do begin
                    JsonArray.Get(i, JsonToken);
                    JsonObject := JsonToken.AsObject();

                    JsonObject.Get('id', JsonToken);
                    PostRecord.Id := JsonToken.AsValue().AsInteger();
                    JsonObject.Get('userId', JsonToken);
                    PostRecord.UserId := JsonToken.AsValue().AsInteger();
                    JsonObject.Get('title', JsonToken);
                    PostRecord.Title := JsonToken.AsValue().AsText();
                    JsonObject.Get('body', JsonToken);
                    PostRecord.Body := JsonToken.AsValue().AsText();
                end;
            end;
        end;
    end;

}