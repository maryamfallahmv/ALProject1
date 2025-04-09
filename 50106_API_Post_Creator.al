codeunit 50106 "API Post Creator"
{
    procedure PostDataToAPI(PostRecord: Record "Temporary Post")
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonText: Text;
        JsonObject: JsonObject;
        JsonContent: Text;
        RequestContent: HttpContent;

    begin
        JsonObject.Add('title', PostRecord.Title);
        JsonObject.Add('body', PostRecord.Body);
        JsonObject.Add('userId', PostRecord.UserId);
        JsonObject.WriteTo(JsonContent);
        RequestContent.WriteFrom(JsonContent);

        HttpClient.Post('https://jsonplaceholder.typicode.com/posts', RequestContent, HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpResponseMessage.Content.ReadAs(JsonText);
            Message('Post created: ' + JsonText);

        end else
            Error('Faled to create a new post');
        ;
    end;

}