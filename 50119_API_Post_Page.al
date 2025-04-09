page 50119 "API Post Page"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Temporary Post";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Id"; Rec.Id) { }
                field("UserId"; Rec.UserId) { }
                field("Title"; Rec.Title) { }
                field("Body"; Rec.Body) { }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PostNew)
            {
                ApplicationArea = All;
                Caption = 'Create New Post';
                Image = New;
                trigger OnAction();
                var
                    PostRecord: Record "Temporary Post";
                    APIPostCreator: CodeUnit "API Post Creator";
                begin
                    PostRecord."Title" := 'New Post Title';
                    PostRecord."Body" := 'This is the body of the new post';
                    PostRecord."UserId" := 11;
                    APIPostCreator.PostDataToAPI(PostRecord);
                end;
            }
            action(FetchPosts)
            {
                ApplicationArea = All;
                Caption = 'Fetch Existing Posts';

                trigger OnAction()
                var
                    APIPostFetcher: Codeunit "API Post Fetcher";
                begin
                    APIPostFetcher.FetchDataFromAPI();
                end;
            }
        }
    }
}